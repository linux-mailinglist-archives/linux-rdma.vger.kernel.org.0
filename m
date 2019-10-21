Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5E8BDF53E
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Oct 2019 20:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729826AbfJUSkw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Oct 2019 14:40:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20347 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728375AbfJUSkw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Oct 2019 14:40:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571683251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lXfaOQYdFL8ye7vXAhaZ8e6i+RwRJU+ydkb4i4rvdUQ=;
        b=Tcrd9eMNbh+5QZ/SJ/X27J+/42zsx8KiHecxPU/x1aNcSzA/BTpvxS2hnMkXVwsmCF8JeU
        0zavPw8I2yZGHtTqEExTLwJ2s/Gnr/lR+evcP3Q3nZIwGWbzJD+yvmF0WCNa+V/T4I4oHD
        j5CxvKOy/4bGjDGvXQsM42/sRDkL4fg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-dWRvfgUUMJusTnloWWIPiA-1; Mon, 21 Oct 2019 14:40:46 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 884DA107AD31;
        Mon, 21 Oct 2019 18:40:44 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.178])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 77EF25D6A5;
        Mon, 21 Oct 2019 18:40:43 +0000 (UTC)
Date:   Mon, 21 Oct 2019 14:40:41 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH hmm 00/15] Consolidate the mmu notifier interval_tree and
 locking
Message-ID: <20191021184041.GF3177@redhat.com>
References: <20191015181242.8343-1-jgg@ziepe.ca>
MIME-Version: 1.0
In-Reply-To: <20191015181242.8343-1-jgg@ziepe.ca>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: dWRvfgUUMJusTnloWWIPiA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 15, 2019 at 03:12:27PM -0300, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
>=20
> 8 of the mmu_notifier using drivers (i915_gem, radeon_mn, umem_odp, hfi1,
> scif_dma, vhost, gntdev, hmm) drivers are using a common pattern where
> they only use invalidate_range_start/end and immediately check the
> invalidating range against some driver data structure to tell if the
> driver is interested. Half of them use an interval_tree, the others are
> simple linear search lists.
>=20
> Of the ones I checked they largely seem to have various kinds of races,
> bugs and poor implementation. This is a result of the complexity in how
> the notifier interacts with get_user_pages(). It is extremely difficult t=
o
> use it correctly.
>=20
> Consolidate all of this code together into the core mmu_notifier and
> provide a locking scheme similar to hmm_mirror that allows the user to
> safely use get_user_pages() and reliably know if the page list still
> matches the mm.
>=20
> This new arrangment plays nicely with the !blockable mode for
> OOM. Scanning the interval tree is done such that the intersection test
> will always succeed, and since there is no invalidate_range_end exposed t=
o
> drivers the scheme safely allows multiple drivers to be subscribed.
>=20
> Four places are converted as an example of how the new API is used.
> Four are left for future patches:
>  - i915_gem has complex locking around destruction of a registration,
>    needs more study
>  - hfi1 (2nd user) needs access to the rbtree
>  - scif_dma has a complicated logic flow
>  - vhost's mmu notifiers are already being rewritten
>=20
> This is still being tested, but I figured to send it to start getting hel=
p
> from the xen, amd and hfi drivers which I cannot test here.

It might be a good oportunity to also switch those users to
hmm_range_fault() instead of GUP as GUP is pointless for those
users. In fact the GUP is an impediment to normal mm operations.

I will test on nouveau.

Cheers,
J=E9r=F4me

