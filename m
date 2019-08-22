Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECC0799800
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Aug 2019 17:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732133AbfHVPT5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Thu, 22 Aug 2019 11:19:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9480 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389039AbfHVPT5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 22 Aug 2019 11:19:57 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7MFBGIi013913
        for <linux-rdma@vger.kernel.org>; Thu, 22 Aug 2019 11:19:55 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.81])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2uhwfmrcwp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Thu, 22 Aug 2019 11:19:55 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Thu, 22 Aug 2019 15:19:54 -0000
Received: from us1a3-smtp01.a3.dal06.isc4sb.com (10.106.154.95)
        by smtp.notes.na.collabserv.com (10.106.227.88) with smtp.notes.na.collabserv.com ESMTP;
        Thu, 22 Aug 2019 15:19:51 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp01.a3.dal06.isc4sb.com
          with ESMTP id 2019082215195114-751422 ;
          Thu, 22 Aug 2019 15:19:51 +0000 
In-Reply-To: <fced439fbf0de8b9036bb071251562b3183debef.camel@redhat.com>
Subject: Re: Re: [PATCH] RDMA/siw: Enable SGL's with mixed memory types
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Doug Ledford" <dledford@redhat.com>
Cc:     linux-rdma@vger.kernel.org, krishna2@chelsio.com
Date:   Thu, 22 Aug 2019 15:19:50 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <fced439fbf0de8b9036bb071251562b3183debef.camel@redhat.com>,<20190822121614.21146-1-bmt@zurich.ibm.com>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP57 August 05, 2019 at 12:42
X-LLNOutbound: False
X-Disclaimed: 2571
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19082215-3067-0000-0000-00000073B71D
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.425523; ST=0; TS=0; UL=0; ISC=; MB=0.174476
X-IBM-SpamModules-Versions: BY=3.00011635; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01250517; UDB=6.00660231; IPR=6.01032073;
 MB=3.00028283; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-22 15:19:54
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-08-22 14:38:42 - 6.00010316
x-cbparentid: 19082215-3068-0000-0000-0000116CCF14
Message-Id: <OF92D4B239.ED07CE6D-ON0025845E.005436BA-0025845E.005436C1@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-22_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



---
Bernard Metzler, PhD
Tech. Leader High Performance I/O, Principal Research Staff
IBM Zurich Research Laboratory
Saeumerstrasse 4
CH-8803 Rueschlikon, Switzerland
+41 44 724 8605

-----"Doug Ledford" <dledford@redhat.com> wrote: -----

>To: "Bernard Metzler" <bmt@zurich.ibm.com>,
>linux-rdma@vger.kernel.org
>From: "Doug Ledford" <dledford@redhat.com>
>Date: 08/22/2019 04:44PM
>Cc: krishna2@chelsio.com
>Subject: [EXTERNAL] Re: [PATCH] RDMA/siw: Enable SGL's with mixed
>memory types
>
>On Thu, 2019-08-22 at 14:16 +0200, Bernard Metzler wrote:
>> This patch enables the transmission of work requests with SGL's
>> of mixed types, e.g. kernel buffers and PBL regions referenced
>> by same work request. This enables iSER as a kernel client.
>> 
>> Reported-by: Krishnamraju Eraparaju <krishna2@chelsio.com>
>> Tested-by: Krishnamraju Eraparaju <krishna2@chelsio.com>
>> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
>
>Hi Bernard,
>
>Commit subject and message are much better this time.  However, it's
>rc5
>already, and we *just* merged siw this merge cycle, so I'd rather
>have
>this in the next -rc pull and not in for-next so that siw "just
>works"
>across the board on initial release.  Your language in a commit
>message
>makes all the difference in the world in terms of whether or not a
>commit should go to for-rc.  In this case, you used "Enable
>SGL's...". 
>Enable is new feature language.  For the rc cycles, you need Fix
>language.  Something like this:
>
>RDMA/siw: Fix SGE element mapping issues
>
>Most upper layer kernel modules submit WQEs where the SG list entries
>are all of a single type.  iSER in particular, however, will send us
>WQEs with mixed SG types: sge[0] = kernel buffer, sge[1] = PBL
>region. 
>Check and set is_kva on each SG entry individually instead of
>assuming
>the first SGE type carries through to the last.  This fixes iSER over
>siw.
>
>Same patch, but the difference in wording makes a world of difference
>in
>terms of whether or not Linus will give you the evil eye for sending
>it
>in an -rc cycle.  And really, you didn't care about enabling SGLs
>with
>mixed memory types.  It's not like that's some sort of sought after
>feature.  It was what was needed to fix siw.  So just remember that
>in
>the future.  Fix language for fixes, enable language for features.

Makes sense, I'll try hard to adhere to that in the future.


>The
>difference does matter ;-)
>
>Please resubmit with a fixed commit message and a Fixes: tag.
>
>-- 
>Doug Ledford <dledford@redhat.com>
>    GPG KeyID: B826A3330E572FDD
>    Fingerprint = AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD
>
[attachment "signature.asc" removed by Bernard Metzler/Zurich/IBM]

