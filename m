Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 602E5E0B02
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Oct 2019 19:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730405AbfJVRxG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Oct 2019 13:53:06 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52758 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729635AbfJVRxG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Oct 2019 13:53:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571766785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2GL6Ua79+M7Cq+4ECwNjr+Wwc2OmFSxszYewlLqFHGg=;
        b=Sm/DDDdYaqliGRYL9A+P2KKM4l8/LcbyRRyaDKo72gcK+bcUmOpNEwQ2KMHumxkkPIBHEw
        PRO66ra+/UQLQtJPWUVcDF8aPMsX1YVvp736SyMDwbo/BnWHSCWeBwqA9Xe5HE5ullAN6z
        63vJZeg4ARv2aJjw/Oq2ikZfeEoemHk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-HacnLdbPNoCIHTPAB16LwQ-1; Tue, 22 Oct 2019 13:53:03 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 422961005509;
        Tue, 22 Oct 2019 17:53:02 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.178])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 96DD35D6A9;
        Tue, 22 Oct 2019 17:53:01 +0000 (UTC)
Date:   Tue, 22 Oct 2019 13:52:59 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v2 2/3] mm/hmm: allow snapshot of the special zero page
Message-ID: <20191022175259.GA5942@redhat.com>
References: <20191015204814.30099-1-rcampbell@nvidia.com>
 <20191015204814.30099-3-rcampbell@nvidia.com>
 <20191021184927.GG3177@redhat.com>
 <95fa45cf-a2ce-fab8-588d-8d806124aef3@nvidia.com>
 <20191022024549.GA4347@redhat.com>
 <20191022150514.GH22766@mellanox.com>
 <20191022170631.GA4805@redhat.com>
 <20191022170916.GL22766@mellanox.com>
 <20191022173026.GB5169@redhat.com>
 <20191022174107.GM22766@mellanox.com>
MIME-Version: 1.0
In-Reply-To: <20191022174107.GM22766@mellanox.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: HacnLdbPNoCIHTPAB16LwQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 22, 2019 at 05:41:11PM +0000, Jason Gunthorpe wrote:
> On Tue, Oct 22, 2019 at 01:30:26PM -0400, Jerome Glisse wrote:
>=20
> > > Smart drivers can test somehow for pfn =3D=3D zero_page and optimize?
> >=20
> > There is nothing to optimize here, i do not know any hardware that
> > have a special page table entry that make all memory access return
> > zero.
>=20
> Presumably any GPU could globally dedicate one page of internal memory
> as a zero page and remap CPU zero page to that internal memory page?
> This is basically how the CPU zero page works.

Yes that would work too but i do not know of any upstream driver
that does that.

> I suspect mlx5 could do the same with its internal memory, but the
> internal memory is too limited to make this worth while.
>=20
> mlx5 also has a specially 'zero MR' that always reads as zero (and
> discards writes), but it doesn't quite fit well into the ODP flow.

Well you can always ask for new stuff to your beloved hardware
engineers, they never say no right ? :)

Cheers,
J=E9r=F4me

