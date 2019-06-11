Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF5C3D0AD
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jun 2019 17:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404654AbfFKPXr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 11 Jun 2019 11:23:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48392 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387864AbfFKPXr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 Jun 2019 11:23:47 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5BFNMP4090923
        for <linux-rdma@vger.kernel.org>; Tue, 11 Jun 2019 11:23:45 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2t2eqg0qaj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Tue, 11 Jun 2019 11:23:44 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Tue, 11 Jun 2019 15:23:43 -0000
Received: from us1a3-smtp05.a3.dal06.isc4sb.com (10.146.71.159)
        by smtp.notes.na.collabserv.com (10.106.227.158) with smtp.notes.na.collabserv.com ESMTP;
        Tue, 11 Jun 2019 15:23:40 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp05.a3.dal06.isc4sb.com
          with ESMTP id 2019061115234012-764532 ;
          Tue, 11 Jun 2019 15:23:40 +0000 
In-Reply-To: <20190610073434.GJ6369@mtr-leonro.mtl.com>
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Leon Romanovsky" <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org
Date:   Tue, 11 Jun 2019 15:23:39 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20190610073434.GJ6369@mtr-leonro.mtl.com>,<20190526114156.6827-1-bmt@zurich.ibm.com>
 <20190526114156.6827-12-bmt@zurich.ibm.com>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP55 May 22, 2019 at 11:09
X-LLNOutbound: False
X-Disclaimed: 8935
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19061115-1335-0000-0000-0000003134A3
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.000065
X-IBM-SpamModules-Versions: BY=3.00011247; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01216480; UDB=6.00639615; IPR=6.00997579;
 MB=3.00027264; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-11 15:23:42
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-06-11 11:19:12 - 6.00010036
x-cbparentid: 19061115-1336-0000-0000-000000BF566A
Message-Id: <OF21B54873.E42B1803-ON00258416.00547EF6-00258416.0054904E@notes.na.collabserv.com>
Subject: Re:  Re: [PATCH for-next v1 11/12] SIW debugging
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-11_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Leon Romanovsky" <leon@kernel.org> wrote: -----

>To: "Bernard Metzler" <bmt@zurich.ibm.com>
>From: "Leon Romanovsky" <leon@kernel.org>
>Date: 06/10/2019 09:35AM
>Cc: linux-rdma@vger.kernel.org
>Subject: [EXTERNAL] Re: [PATCH for-next v1 11/12] SIW debugging
>
>On Sun, May 26, 2019 at 01:41:55PM +0200, Bernard Metzler wrote:
>> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
>> ---
>>  drivers/infiniband/sw/siw/siw_debug.c | 102
>++++++++++++++++++++++++++
>>  drivers/infiniband/sw/siw/siw_debug.h |  35 +++++++++
>>  2 files changed, 137 insertions(+)
>>  create mode 100644 drivers/infiniband/sw/siw/siw_debug.c
>>  create mode 100644 drivers/infiniband/sw/siw/siw_debug.h
>
>1. Use Gal's ibdev_* prints.

I'll have a look now. 

>2. Remove all your custom siw_print_hdr() thing. It belongs to custom
>debug kernel which you can use in-house, but not for upstream and
>globally distributed code. Our assumption that code works.

OK will remove. Have to say siw initially targeted RDMA application
debugging, that's why it had that many debug statements. slowly cleaning up ;)

>
>Thanks
>
>

