Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 089CEAD940
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2019 14:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbfIIMl0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 9 Sep 2019 08:41:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34952 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728095AbfIIMlZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Sep 2019 08:41:25 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x89CcJMJ008430
        for <linux-rdma@vger.kernel.org>; Mon, 9 Sep 2019 08:41:24 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.82])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2uwnfwvka1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Mon, 09 Sep 2019 08:41:24 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Mon, 9 Sep 2019 12:41:23 -0000
Received: from us1a3-smtp03.a3.dal06.isc4sb.com (10.106.154.98)
        by smtp.notes.na.collabserv.com (10.106.227.105) with smtp.notes.na.collabserv.com ESMTP;
        Mon, 9 Sep 2019 12:41:19 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp03.a3.dal06.isc4sb.com
          with ESMTP id 2019090912411956-471296 ;
          Mon, 9 Sep 2019 12:41:19 +0000 
In-Reply-To: <20190909100334.GE6601@unreal>
Subject: Re: Re: [PATCH] RDMA/siw: Fix page address mapping in TX path
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Leon Romanovsky" <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, krishna2@chelsio.com,
        dledford@redhat.com
Date:   Mon, 9 Sep 2019 12:41:19 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20190909100334.GE6601@unreal>,<20190906142149.15674-1-bmt@zurich.ibm.com>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP57 August 05, 2019 at 12:42
X-LLNOutbound: False
X-Disclaimed: 30175
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19090912-9463-0000-0000-000000C245C3
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.082673
X-IBM-SpamModules-Versions: BY=3.00011742; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01258907; UDB=6.00665380; IPR=6.01040650;
 MB=3.00028543; MTD=3.00000008; XFM=3.00000015; UTC=2019-09-09 12:41:22
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-09-09 06:38:34 - 6.00010386
x-cbparentid: 19090912-9464-0000-0000-000028794D80
Message-Id: <OF2F5CA08D.DA40B35D-ON00258470.0044C261-00258470.0045B36B@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-09_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Leon Romanovsky" <leon@kernel.org> wrote: -----

>To: "Bernard Metzler" <bmt@zurich.ibm.com>
>From: "Leon Romanovsky" <leon@kernel.org>
>Date: 09/09/2019 12:03PM
>Cc: linux-rdma@vger.kernel.org, krishna2@chelsio.com,
>dledford@redhat.com
>Subject: [EXTERNAL] Re: [PATCH] RDMA/siw: Fix page address mapping in
>TX path
>
>On Fri, Sep 06, 2019 at 04:21:49PM +0200, Bernard Metzler wrote:
>> Use the correct kmap()/kunmap() flow to determine page
>> address used for CRC computation. Using page_address()
>> is wrong, since page might be in highmem.
>>
>> Reported-by: Krishnamraju Eraparaju <krishna2@chelsio.com>
>> Fixes: b9be6f18cf9e ("rdma/siw: transmit path")
>> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
>> ---
>>  drivers/infiniband/sw/siw/siw_qp_tx.c | 11 ++++++-----
>>  1 file changed, 6 insertions(+), 5 deletions(-)
>
>Bernard,
>
>You need to write version and target in your title [PATCH v100
>rdma-next] ...
>And changelog.

Thanks Leon,
will do. I'd like to have that accepted asap,
since it is a code fix. The driver would crash if it
tries CRC on data in highmem. So let me mark it
'for-rc'. Or would 'rdma-rc' be better? Just see
these two variants on the list...


Thanks!
Bernard.
>
>Thanks
>
>

