Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 015E72A6727
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Nov 2020 16:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728403AbgKDPJJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Nov 2020 10:09:09 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38144 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726801AbgKDPJJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Nov 2020 10:09:09 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A4F3wGJ073392
        for <linux-rdma@vger.kernel.org>; Wed, 4 Nov 2020 10:09:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=in-reply-to : subject :
 from : to : cc : date : references : content-type : message-id :
 content-transfer-encoding : mime-version; s=pp1;
 bh=7FPG47AqrPRMgjGCg5C10UsZjtjnYr6jvMRwngJtz2c=;
 b=lZRNvvZpYv2B/HjwDd5zuwzB8z+v5DmCiQ4u0ir3nMxiWAvgOwxZRUmKOguXO6/Fbwiu
 wlyK4KNVXPWL6tKaMgCe7VULcTdZKzpXVhc+GLhH6fyYN5lqgF7Vzrewmw5JB1LxOa58
 yASFCasc3eIqQKtoI3sk8KI3ns26U2YgWDxJW+zLUXH4ISmeKNGGBUSk5EkEl1sdkBVh
 4E7tiNtpGxww3kxSiBIcNZqZ+PIJozN5xEPBIazM17r8u6ovX7w2tC7jHU7J38Nev628
 MYRfr681Ay8FbDi69RZDgAU+CaLI8PO15GDGsTj+ugzNf1MW5KXPMhOnMu2mSrJM4Byh Mg== 
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.112])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34kn32b29h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Wed, 04 Nov 2020 10:09:08 -0500
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Wed, 4 Nov 2020 15:09:07 -0000
Received: from us1b3-smtp04.a3dr.sjc01.isc4sb.com (10.122.203.161)
        by smtp.notes.na.collabserv.com (10.122.47.54) with smtp.notes.na.collabserv.com ESMTP;
        Wed, 4 Nov 2020 15:09:05 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp04.a3dr.sjc01.isc4sb.com
          with ESMTP id 2020110415090513-490636 ;
          Wed, 4 Nov 2020 15:09:05 +0000 
In-Reply-To: <20201104140108.GA5674@lst.de>
Subject: Re: Re: [PATCH 2/5] RDMA/core: remove use of dma_virt_ops
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Christoph Hellwig" <hch@lst.de>
Cc:     "Jason Gunthorpe" <jgg@ziepe.ca>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        "Logan Gunthorpe" <logang@deltatee.com>,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org
Date:   Wed, 4 Nov 2020 15:09:04 +0000
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20201104140108.GA5674@lst.de>,<20201104095052.1222754-1-hch@lst.de>
 <20201104095052.1222754-3-hch@lst.de> <20201104134241.GP36674@ziepe.ca>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP65 April 15, 2020 at 09:48
X-KeepSent: FDBE80DE:245A259C-00258616:00528DDA;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 54487
X-TNEFEvaluated: 1
Content-Type: text/plain; charset=UTF-8
x-cbid: 20110415-4615-0000-0000-0000030A33C5
X-IBM-SpamModules-Scores: BY=0.020974; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.378364; ST=0; TS=0; UL=0; ISC=; MB=0.000014
X-IBM-SpamModules-Versions: BY=3.00014135; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000295; SDB=6.01459084; UDB=6.00785062; IPR=6.01241745;
 MB=3.00034858; MTD=3.00000008; XFM=3.00000015; UTC=2020-11-04 15:09:06
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2020-11-04 13:11:13 - 6.00012032
x-cbparentid: 20110415-4616-0000-0000-000003BC3BEE
Message-Id: <OFFDBE80DE.245A259C-ON00258616.00528DDA-00258616.00533A9D@notes.na.collabserv.com>
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-04_08:2020-11-04,2020-11-04 signatures=0
X-Proofpoint-Spam-Reason: orgsafe
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Christoph Hellwig" <hch@lst.de> wrote: -----

>To: "Jason Gunthorpe" <jgg@ziepe.ca>
>From: "Christoph Hellwig" <hch@lst.de>
>Date: 11/04/2020 03:02PM
>Cc: "Christoph Hellwig" <hch@lst.de>, "Bjorn Helgaas"
><bhelgaas@google.com>, "Logan Gunthorpe" <logang@deltatee.com>,
>linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
>iommu@lists.linux-foundation.org
>Subject: [EXTERNAL] Re: [PATCH 2/5] RDMA/core: remove use of
>dma_virt_ops
>
>On Wed, Nov 04, 2020 at 09:42:41AM -0400, Jason Gunthorpe wrote:
>> On Wed, Nov 04, 2020 at 10:50:49AM +0100, Christoph Hellwig wrote:
>>=20
>> > +int ib_dma_virt_map_sg(struct ib_device *dev, struct scatterlist
>*sg, int nents)
>> > +{
>> > +	struct scatterlist *s;
>> > +	int i;
>> > +
>> > +	for_each_sg(sg, s, nents, i) {
>> > +		sg_dma_address(s) =3D (uintptr_t)sg_virt(s);
>> > +		sg_dma_len(s) =3D s->length;
>>=20
>> Hmm.. There is nothing ensuring the page is mapped here for this
>> sg_virt(). Before maybe some of the kconfig stuff prevented highmem
>> systems indirectly, I wonder if we should add something more direct
>to
>> exclude highmem for these drivers?
>
>I had actually noticed this earlier as well and then completely
>forgot
>about it..
>
>rdmavt depends on X86_64, so it can't be used with highmem, but for
>rxe and siw there weren't any such dependencies so I think we were
>just
>lucky.  Let me send a fix to add explicit depencies and then respin
>this
>series on top of that..
>
>> Sigh. I think the proper fix is to replace addr/length with a
>> scatterlist pointer in the struct ib_sge, then have SW drivers
>> directly use the page pointer properly.
>
>The proper fix is to move the DMA mapping into the RDMA core, yes.
>And as you said it will be hard.  But I don't think scatterlists
>are the right interface.  IMHO we can keep re-use the existing
>struct ib_sge:
>
>struct ib_ge {
>	u64     addr;
>	u32     length;
>	u32     lkey;
>};
>
>with the difference that if lkey is not a MR, addr is the physical
>address of the memory, not a dma_addr_t or virtual address.
>

lkey of zero to pass a physical buffer, only allowed for
kernel applications? Very nice idea I think.

btw.
It would even get the vain blessing of the old IETF RDMA
verbs draft ;)

https://tools.ietf.org/html/draft-hilland-rddp-verbs-00#page-90


(section '7.2.1 STag of zero' - read lkey for STag)


