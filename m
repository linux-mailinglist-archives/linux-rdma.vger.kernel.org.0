Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B85A1DF638
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Oct 2019 21:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729270AbfJUTr5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Oct 2019 15:47:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23667 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726672AbfJUTr4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Oct 2019 15:47:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571687275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=61Nnku0I+13ll91wxHp2GCqWsterOpYjidrMjRQ6FOk=;
        b=FgXx8MPj2E5264FKUKvWQbruJp1cI/6JkRubU1VJQfFvoubEx+GLp/4P4dgRAKSQ/omar4
        T6vDwlwnUHe6jTlViX5l/cqIB4V2yaJvOMZf6PbtjnZ8+uV5Ccx+CWIh9f/GjiISwr9mtF
        E5+Ghp2essq6A+MdDcmipjIu6p0BDv0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-tvVLh5QnNemqg5-Lf0njnA-1; Mon, 21 Oct 2019 15:47:52 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6C07800D41;
        Mon, 21 Oct 2019 19:47:50 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.178])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DB9105C219;
        Mon, 21 Oct 2019 19:47:49 +0000 (UTC)
Date:   Mon, 21 Oct 2019 15:47:48 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "Felix.Kuehling@amd.com" <Felix.Kuehling@amd.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH hmm 02/15] mm/mmu_notifier: add an interval tree notifier
Message-ID: <20191021194748.GA5644@redhat.com>
References: <20191015181242.8343-1-jgg@ziepe.ca>
 <20191015181242.8343-3-jgg@ziepe.ca>
 <20191021183056.GA3177@redhat.com>
 <20191021185421.GG6285@mellanox.com>
 <20191021191157.GA5208@redhat.com>
 <20191021192448.GK6285@mellanox.com>
MIME-Version: 1.0
In-Reply-To: <20191021192448.GK6285@mellanox.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: tvVLh5QnNemqg5-Lf0njnA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 21, 2019 at 07:24:53PM +0000, Jason Gunthorpe wrote:
> On Mon, Oct 21, 2019 at 03:11:57PM -0400, Jerome Glisse wrote:
> > > Since that reader is not locked we need release semantics here to
> > > ensure the unlocked reader sees a fully initinalized mmu_notifier_mm
> > > structure when it observes the pointer.
> >=20
> > I thought the mm_take_all_locks() would have had a barrier and thus
> > that you could not see mmu_notifier struct partialy initialized.=20
>=20
> Not sure, usually a lock acquire doesn't have a store barrier?

Yeah likely.

>=20
> Even if it did, we would still need some pairing read barrier..
>=20
> > having the acquire/release as safety net does not hurt. Maybe add a
> > comment about the struct initialization needing to be visible before
> > pointer is set.
>=20
> Is this clear?
>=20
>          * release semantics on the initialization of the
>          * mmu_notifier_mm's contents are provided for unlocked readers.
> =09 * acquire can only be used while holding the
>          * mmgrab or mmget, and is safe because once created the
>          * mmu_notififer_mm is not freed until the mm is destroyed.
>          * Users holding the mmap_sem or one of the
> =09 * mm_take_all_locks() do not need to use acquire semantics.
>=20
> It also helps explain why there is no locking around the other
> readers, which has puzzled me in the past at least.

Perfect.

J=E9r=F4me

