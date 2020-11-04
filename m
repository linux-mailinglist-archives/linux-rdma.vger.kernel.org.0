Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9702A658C
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Nov 2020 14:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgKDNxS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Nov 2020 08:53:18 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41880 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726527AbgKDNxR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Nov 2020 08:53:17 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A4DWuhA048134
        for <linux-rdma@vger.kernel.org>; Wed, 4 Nov 2020 08:53:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=in-reply-to : from : to
 : cc : date : mime-version : references : content-transfer-encoding :
 content-type : message-id : subject; s=pp1;
 bh=QWHDoiWLqaWLdR6jaMQbPSeFVUFDNgyFa69IQJ8LZFA=;
 b=pWpF6BUOmmWjZqHEKq6iQntxazvmF0jsqlVWhsfq2tCcM2U7RSolxTkx6cgxDc8v/Khm
 OXO3S5Lq9AoMIzpF01mCGkk1A9jnuMcQAYH6NoGws/x+OBJzl2sn8cJu36v0U6rVL+0d
 pQHqs+2JiLac9M1Rld8c2BAg+8IIsLLV4IUVGK+royYJnSwJgrLEolfuIGmdVau6kFQ3
 eK38bA2s6P6T54dyD7vU4p4dZBEduIPPu578ggy/U62+qD9j5vFl6LwvZGbuO+z3CJtc
 xMRX/EX+MpY927F4X1Dq2yOqGj40Jbmp5FLHZCcRh0EdQmta7G5+YFw1ntq8J7bgftJ9 Eg== 
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.66])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34ktutwkc5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Wed, 04 Nov 2020 08:53:17 -0500
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Wed, 4 Nov 2020 13:53:16 -0000
Received: from us1a3-smtp05.a3.dal06.isc4sb.com (10.146.71.159)
        by smtp.notes.na.collabserv.com (10.106.227.127) with smtp.notes.na.collabserv.com ESMTP;
        Wed, 4 Nov 2020 13:53:14 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp05.a3.dal06.isc4sb.com
          with ESMTP id 2020110413531429-431102 ;
          Wed, 4 Nov 2020 13:53:14 +0000 
In-Reply-To: <f8de77b3-d9c7-5b0f-c118-c95f0c6a271c@gmail.com>
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Bob Pearson" <rpearsonhpe@gmail.com>
Cc:     "Jason Gunthorpe" <jgg@nvidia.com>,
        "Leon Romanovsky" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Date:   Wed, 4 Nov 2020 13:53:14 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <f8de77b3-d9c7-5b0f-c118-c95f0c6a271c@gmail.com>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP65 April 15, 2020 at 09:48
X-LLNOutbound: False
X-Disclaimed: 4083
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
x-cbid: 20110413-4409-0000-0000-000004003A8A
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.003452
X-IBM-SpamModules-Versions: BY=3.00014135; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000295; SDB=6.01459059; UDB=6.00785047; IPR=6.01241719;
 MB=3.00034857; MTD=3.00000008; XFM=3.00000015; UTC=2020-11-04 13:53:15
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2020-11-04 12:50:09 - 6.00012032
x-cbparentid: 20110413-4410-0000-0000-0000A5EF43C0
Message-Id: <OFB1D10315.3DD6DADF-ON00258616.004C490E-00258616.004C4915@notes.na.collabserv.com>
Subject: Re:  pyverbs test regression
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-04_08:2020-11-04,2020-11-04 signatures=0
X-Proofpoint-Spam-Reason: orgsafe
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Bob Pearson" <rpearsonhpe@gmail.com> wrote: -----

>To: "Jason Gunthorpe" <jgg@nvidia.com>, "Leon Romanovsky"
><leon@kernel.org>
>From: "Bob Pearson" <rpearsonhpe@gmail.com>
>Date: 11/04/2020 12:55AM
>Cc: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
>Subject: [EXTERNAL] pyverbs test regression
>
>Since 5.10 some of the pyverbs tests are skipping with the warning
>	"Device rxe=5F0 doesn't have net interface"
>
>These occur in tests/test=5Frdmacm.py. As far as I can tell the error
>occurs in
>
>RDMATestCase =5Fadd=5Fgids=5Fper=5Fport after the following
>
>	    if not
>os.path.exists('/sys/class/infiniband/{}/device/net/'.format(dev)):
>                self.args.append([dev, port, idx, None])
>                continue
>
>In fact there is no such path which means it never finds an ip=5Faddr
>for the device.
>
>Did something change here? Do other RDMA devices have
>/sys/class/infiniband/XXX/device/net?
>

Hmm, with 5.10.0-rc1, I still see it for both rdma=5Frxe and siw.=20

