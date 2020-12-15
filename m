Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25DC52DB484
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Dec 2020 20:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbgLOTgV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Dec 2020 14:36:21 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37914 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725821AbgLOTgU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 15 Dec 2020 14:36:20 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BFJWlYh070620
        for <linux-rdma@vger.kernel.org>; Tue, 15 Dec 2020 14:35:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=in-reply-to : subject :
 from : to : cc : date : mime-version : references :
 content-transfer-encoding : content-type : message-id; s=pp1;
 bh=UKzW9BqnXXwM+6ii7AqIUISXKtJ9gr8ZMMNqd8HV9hQ=;
 b=H9g1RiMaJWI2UdC9yJCq6n4AYC0sHznVnKq645FQckV65lwktKpuw/b/gkGtQwWz/Qrq
 gG9YVayTolaud4RePhO7PWWjRngRDwPVToxsuWan2mR0lOBN3hB8oR9g5f0VE8Do831r
 QlnN3J9JYnlx8rajAB+yMc6buPoKFfovLLSF6ctkxP0MahCY7oDLAB9y6URXXnjwZxeJ
 ykEg7ngV0AkcxLkhhi8Whk/P/gclZ2aAQbY2cuaODOSWqlyqz4uXwjIeAfMCczULTKUo
 iIsaivR+/pPqGDYzb1izv2Hrht1h9n66SUR/1Ed4NcLMAsRXbaP7Jg8yJasgRZFOyKw9 XA== 
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.119])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35f1ar4exh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Tue, 15 Dec 2020 14:35:39 -0500
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Tue, 15 Dec 2020 19:35:38 -0000
Received: from us1b3-smtp01.a3dr.sjc01.isc4sb.com (10.122.7.174)
        by smtp.notes.na.collabserv.com (10.122.182.123) with smtp.notes.na.collabserv.com ESMTP;
        Tue, 15 Dec 2020 19:35:36 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp01.a3dr.sjc01.isc4sb.com
          with ESMTP id 2020121519353576-694740 ;
          Tue, 15 Dec 2020 19:35:35 +0000 
In-Reply-To: <20201215174717.GZ552508@nvidia.com>
Subject: Re: Re: [PATCH] RDMA/siw: Fix handling of zero-sized Read and Receive
 Queues.
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Jason Gunthorpe" <jgg@nvidia.com>
Cc:     <linux-rdma@vger.kernel.org>, <kamalheib1@gmail.com>,
        <yi.zhang@redhat.com>, <linux-nvme@lists.infradead.org>
Date:   Tue, 15 Dec 2020 19:35:35 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20201215174717.GZ552508@nvidia.com>,<20201215122306.3886-1-bmt@zurich.ibm.com>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP65 April 15, 2020 at 09:48
X-KeepSent: 33B51ADA:D0F7149E-0025863F:00628A52;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 11451
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
x-cbid: 20121519-3975-0000-0000-0000036D5596
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.399202; ST=0; TS=0; UL=0; ISC=; MB=0.000684
X-IBM-SpamModules-Versions: BY=3.00014381; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000295; SDB=6.01478589; UDB=6.00796658; IPR=6.01261195;
 MB=3.00035512; MTD=3.00000008; XFM=3.00000015; UTC=2020-12-15 19:35:37
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2020-12-15 17:42:41 - 6.00012142
x-cbparentid: 20121519-3976-0000-0000-000077248F3A
Message-Id: <OF33B51ADA.D0F7149E-ON0025863F.00628A52-0025863F.006BA0D9@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-15_12:2020-12-15,2020-12-15 signatures=0
X-Proofpoint-Spam-Reason: orgsafe
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Jason Gunthorpe" <jgg@nvidia.com> wrote: -----

>To: "Bernard Metzler" <bmt@zurich.ibm.com>
>From: "Jason Gunthorpe" <jgg@nvidia.com>
>Date: 12/15/2020 06:48PM
>Cc: <linux-rdma@vger.kernel.org>, <kamalheib1@gmail.com>,
><yi.zhang@redhat.com>, <linux-nvme@lists.infradead.org>
>Subject: [EXTERNAL] Re: [PATCH] RDMA/siw: Fix handling of zero-sized
>Read and Receive Queues.
>
>On Tue, Dec 15, 2020 at 01:23:06PM +0100, Bernard Metzler wrote:
>> During connection setup, the application may choose to zero-size
>> inbound and outbound READ queues, as well as the Receive queue.
>> This patch fixes handling of zero-sized queues.
>
>This fixes a crasher? Copy the fixes line and oops from  Kamal?
>
>Jason
>
Yes. it does. Will resend with a small change fixing
an uninitialized variable I just invented with the patch (uuuhh).

I will attach Kamal's oops report, but his fix was
blocking allowed application behavior (setting some queue
sizes to zero). The intention of my patch is to fix siw
to handle that application behavior correctly. So the fixes
lines will be different.
=20

Thanks,
Bernard.

