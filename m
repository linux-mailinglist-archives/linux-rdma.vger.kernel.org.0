Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84CAC274415
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Sep 2020 16:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgIVOWH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Sep 2020 10:22:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38134 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726494AbgIVOWH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Sep 2020 10:22:07 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08ME5Tit010872
        for <linux-rdma@vger.kernel.org>; Tue, 22 Sep 2020 10:22:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=in-reply-to : from : to
 : cc : date : mime-version : references : content-transfer-encoding :
 content-type : message-id : subject; s=pp1;
 bh=fjyVaKFq9FrsbDELUSzfS68bdCUQFsy0uVx8wtyGp2I=;
 b=eSKSeNeA1R5o9kG8jtx/yGe4bCkDttHWkgnDMkHDLDgkSlu8qG74IMz6mta29qUcaP2o
 0e1/q/PqsJ6bEeH6m6oYazyS1UFRd5bQJPsmo4BZMUgn1DcK5UTzYER98qFXo1VlBX18
 48cj0CeDp9Ax4tz8x2sd6xA+3KBsqo+shGZWrDI9MqiCrU0TUL0uuOjiMYslIRIU5/2n
 gy7m3gxiM6jQ5qdb34b95l8nZvmBEAGvRbSYNZng1wfWyOrRAoTTM14HIpHbSDjfOPRx
 BrBI7oykUcabS1IbO7pDsc2eISVNfpuqDc9+tcx+GDiL7hWhq3OtnAEqNPDmnORTHz0Y GA== 
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.104])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33qjdgsapt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Tue, 22 Sep 2020 10:22:05 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Tue, 22 Sep 2020 14:22:04 -0000
Received: from us1b3-smtp05.a3dr.sjc01.isc4sb.com (10.122.203.183)
        by smtp.notes.na.collabserv.com (10.122.47.44) with smtp.notes.na.collabserv.com ESMTP;
        Tue, 22 Sep 2020 14:22:02 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp05.a3dr.sjc01.isc4sb.com
          with ESMTP id 2020092214220197-445391 ;
          Tue, 22 Sep 2020 14:22:01 +0000 
In-Reply-To: <20200922101429.GF1223944@unreal>
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Leon Romanovsky" <leon@kernel.org>
Cc:     "Doug Ledford" <dledford@redhat.com>,
        "Jason Gunthorpe" <jgg@nvidia.com>,
        "Adit Ranadive" <aditr@vmware.com>,
        "Ariel Elior" <aelior@marvell.com>,
        "Christian Benvenuti" <benve@cisco.com>,
        "Dennis Dalessandro" <dennis.dalessandro@intel.com>,
        "Devesh Sharma" <devesh.sharma@broadcom.com>,
        "Faisal Latif" <faisal.latif@intel.com>,
        "Gal Pressman" <galpress@amazon.com>,
        "Lijun Ou" <oulijun@huawei.com>, linux-rdma@vger.kernel.org,
        "Michal Kalderon" <mkalderon@marvell.com>,
        "Mike Marciniszyn" <mike.marciniszyn@intel.com>,
        "Naresh Kumar PBS" <nareshkumar.pbs@broadcom.com>,
        "Nelson Escobar" <neescoba@cisco.com>,
        "Parav Pandit" <parav@nvidia.com>,
        "Parvi Kaustubhi" <pkaustub@cisco.com>,
        "Potnuri Bharat Teja" <bharat@chelsio.com>,
        "Selvin Xavier" <selvin.xavier@broadcom.com>,
        "Shiraz Saleem" <shiraz.saleem@intel.com>,
        "Somnath Kotur" <somnath.kotur@broadcom.com>,
        "Sriharsha Basavapatna" <sriharsha.basavapatna@broadcom.com>,
        "VMware PV-Drivers" <pv-drivers@vmware.com>,
        "Weihang Li" <liweihang@huawei.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        "Yishai Hadas" <yishaih@nvidia.com>,
        "Zhu Yanjun" <yanjunz@nvidia.com>
Date:   Tue, 22 Sep 2020 14:22:01 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20200922101429.GF1223944@unreal>,<20200922082745.2149973-1-leon@kernel.org>
 <OFA7334E75.E0306A27-ON002585EB.003059A0-002585EB.0031440E@notes.na.collabserv.com>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP65 April 15, 2020 at 09:48
X-KeepSent: E5279622:4F47648E-002585EB:004EEBC0;
 type=4; flags=0; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 31027
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
x-cbid: 20092214-5525-0000-0000-000003552933
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.399202; ST=0; TS=0; UL=0; ISC=; MB=0.000030
X-IBM-SpamModules-Versions: BY=3.00013874; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000295; SDB=6.01438550; UDB=6.00772860; IPR=6.01221236;
 MB=3.00034186; MTD=3.00000008; XFM=3.00000015; UTC=2020-09-22 14:22:04
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2020-09-22 08:28:30 - 6.00011869
x-cbparentid: 20092214-5526-0000-0000-0000F0632BE4
Message-Id: <OFE5279622.4F47648E-ON002585EB.004EEBC0-002585EB.004EEBDA@notes.na.collabserv.com>
Subject: RE: [PATCH rdma-next] RDMA: Explicitly pass in the dma_device to
 ib_register_device
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-22_13:2020-09-21,2020-09-22 signatures=0
X-Proofpoint-Spam-Reason: orgsafe
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

...

>> >diff --git a/drivers/infiniband/sw/siw/siw=5Fmain.c
>> >b/drivers/infiniband/sw/siw/siw=5Fmain.c
>> >index d862bec84376..0362d57b4db8 100644
>> >--- a/drivers/infiniband/sw/siw/siw=5Fmain.c
>> >+++ b/drivers/infiniband/sw/siw/siw=5Fmain.c
>> >@@ -69,7 +69,7 @@ static int siw=5Fdevice=5Fregister(struct siw=5Fdevice
>> >*sdev, const char *name)
>> >
>> > 	sdev->vendor=5Fpart=5Fid =3D dev=5Fid++;
>> >
>> >-	rv =3D ib=5Fregister=5Fdevice(base=5Fdev, name);
>> >+	rv =3D ib=5Fregister=5Fdevice(base=5Fdev, name, NULL);
>> > 	if (rv) {
>> > 		pr=5Fwarn("siw: device registration error %d\n", rv);
>> > 		return rv;
>> >@@ -386,6 +386,8 @@ static struct siw=5Fdevice
>> >*siw=5Fdevice=5Fcreate(struct net=5Fdevice *netdev)
>> > 	base=5Fdev->dev.dma=5Fparms =3D &sdev->dma=5Fparms;
>> > 	sdev->dma=5Fparms =3D (struct device=5Fdma=5Fparameters)
>> > 		{ .max=5Fsegment=5Fsize =3D SZ=5F2G };
>> >+	dma=5Fcoerce=5Fmask=5Fand=5Fcoherent(&base=5Fdev->dev,
>> >+				     dma=5Fget=5Frequired=5Fmask(&base=5Fdev->dev));
>>
>> Leon, can you please help me to understand this
>> additional logic? Do we need to setup the DMA device
>> for (software) RDMA devices which rely on dma=5Fvirt=5Fops
>> in the end, or better leave it untouched?
>
>The logic that driver is responsible to give right DMA device,
>so yes, you are setting here mask from dma=5Fvirt=5Fops, as RXE did.
>
Thanks Leon!

I wonder how this was working w/o that before!

Many thanks,
Bernard.

