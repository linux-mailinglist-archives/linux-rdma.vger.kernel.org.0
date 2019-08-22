Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB49599987
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Aug 2019 18:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390165AbfHVQqa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Thu, 22 Aug 2019 12:46:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33020 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390124AbfHVQqa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 22 Aug 2019 12:46:30 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7MGhgAi143636
        for <linux-rdma@vger.kernel.org>; Thu, 22 Aug 2019 12:46:29 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uhw55muqu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Thu, 22 Aug 2019 12:46:29 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Thu, 22 Aug 2019 16:46:28 -0000
Received: from us1a3-smtp01.a3.dal06.isc4sb.com (10.106.154.95)
        by smtp.notes.na.collabserv.com (10.106.227.158) with smtp.notes.na.collabserv.com ESMTP;
        Thu, 22 Aug 2019 16:46:21 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp01.a3.dal06.isc4sb.com
          with ESMTP id 2019082216462124-840633 ;
          Thu, 22 Aug 2019 16:46:21 +0000 
In-Reply-To: <20190822130829.GE29433@mtr-leonro.mtl.com>
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Leon Romanovsky" <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, jgg@ziepe.ca, geert@linux-m68k.org
Date:   Thu, 22 Aug 2019 16:46:20 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20190822130829.GE29433@mtr-leonro.mtl.com>,<20190820172221.6274-1-bmt@zurich.ibm.com>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP57 August 05, 2019 at 12:42
X-LLNOutbound: False
X-Disclaimed: 779
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19082216-1335-0000-0000-0000011DD66F
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.061899
X-IBM-SpamModules-Versions: BY=3.00011635; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01250546; UDB=6.00660249; IPR=6.01032102;
 MB=3.00028283; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-22 16:46:26
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-08-22 15:19:09 - 6.00010316
x-cbparentid: 19082216-1336-0000-0000-000003C3F055
Message-Id: <OF63DBE1D9.37EF328B-ON0025845E.005C1879-0025845E.005C2225@notes.na.collabserv.com>
Subject: RE: [PATCH v2] RDMA/siw: fix 64/32bit pointer inconsistency
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-22_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Leon Romanovsky" <leon@kernel.org> wrote: -----

>To: "Bernard Metzler" <bmt@zurich.ibm.com>
>From: "Leon Romanovsky" <leon@kernel.org>
>Date: 08/22/2019 03:09PM
>Cc: linux-rdma@vger.kernel.org, jgg@ziepe.ca, geert@linux-m68k.org
>Subject: [EXTERNAL] Re: [PATCH v2] RDMA/siw: fix 64/32bit pointer
>inconsistency
>
>On Tue, Aug 20, 2019 at 07:22:21PM +0200, Bernard Metzler wrote:
>> Fixes improper casting between addresses and unsigned types.
>> Changes siw_pbl_get_buffer() function to return appropriate
>> dma_addr_t, and not u64.
>>
>> In debug prints, all potentially kernel private variables
>> are printed as void * to allow keeping that information
>> secret.
>
>It is done by using %pK and not by strange casting.

Thanks Leon, will resubmit. I will also take the chance to drop
some of it completely.

Bernard

