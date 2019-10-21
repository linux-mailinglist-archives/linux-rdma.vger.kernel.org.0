Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7536DF5DE
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Oct 2019 21:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730132AbfJUTTa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Oct 2019 15:19:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38756 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730127AbfJUTTa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Oct 2019 15:19:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571685569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XvQMWms2Ef0GKQbYBZu3QSp4iD5UdUfpEnyzpzRVcdo=;
        b=iPuerWb/WuXX7/GXllntnTOlArtQiCIFfCMJJfxuPgWQtij0VmMkWaAi1wHuP0lZB+KOL6
        cHoPgWHDPyWZeQW7NZR49DeZ+0l6uaGfMlNBtjOreBE0LX0eFuw/MxMLBuQMBrVAuKu8Mk
        7cK8Pma1YPJ1uFi9cK26hMd7HsGtb4o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-pucvyFZ9O-qowyYJDMXeyA-1; Mon, 21 Oct 2019 15:19:26 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC2FE47B;
        Mon, 21 Oct 2019 19:19:24 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.178])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A55836012D;
        Mon, 21 Oct 2019 19:19:23 +0000 (UTC)
Date:   Mon, 21 Oct 2019 15:19:22 -0400
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
        Ben Skeggs <bskeggs@redhat.com>
Subject: Re: [PATCH hmm 15/15] mm/hmm: remove hmm_mirror and related
Message-ID: <20191021191922.GB5208@redhat.com>
References: <20191015181242.8343-1-jgg@ziepe.ca>
 <20191015181242.8343-16-jgg@ziepe.ca>
 <20191021183824.GE3177@redhat.com>
 <20191021185738.GH6285@mellanox.com>
MIME-Version: 1.0
In-Reply-To: <20191021185738.GH6285@mellanox.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: pucvyFZ9O-qowyYJDMXeyA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 21, 2019 at 06:57:42PM +0000, Jason Gunthorpe wrote:
> On Mon, Oct 21, 2019 at 02:38:24PM -0400, Jerome Glisse wrote:
> > On Tue, Oct 15, 2019 at 03:12:42PM -0300, Jason Gunthorpe wrote:
> > > From: Jason Gunthorpe <jgg@mellanox.com>
> > >=20
> > > The only two users of this are now converted to use mmu_range_notifie=
r,
> > > delete all the code and update hmm.rst.
> >=20
> > I guess i should point out that the reasons for hmm_mirror and hmm
> > was for:
> >     1) Maybe define a common API for userspace to provide memory
> >        placement hints (NUMA for GPU)
>=20
> Do you think this needs special code in the notifiers?

Just need a place where to hang userspace policy hint the hmm_range
was the prime suspect. I need to revisit this once the nouveau user
space is in better shape.

>=20
> >     2) multi-devices sharing same mirror page table
>=20
> Oh neat, but I think this just means the GPU driver has to register a
> single notifier for multiple GPUs??

Yes that was the idea a single notifier with share page table, but
at this time this is non existent code so no need to hinder change
just for the sake of it.

>=20
> > But support for multi-GPU in nouveau is way behind and i guess such
> > optimization will have to re-materialize what is necessary once that
> > happens.
>=20
> Sure, it will be easier to understand what is needed with a bit of
> code!
>=20
> > Note this patch should also update kernel/fork.c and the mm_struct
> > definition AFAICT. With those changes you can add my:
>=20
> Can you please elaborate what updates you mean? I'm not sure.=20
>=20
> Maybe I already got the things you are thinking of with the get/put
> changes?

Oh i forgot this was already taken care of by this. So yes all is
fine:

Reviewed-by: J=E9r=F4me Glisse <jglisse@redhat.com>

