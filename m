Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3127397B2B
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2019 15:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbfHUNn2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Wed, 21 Aug 2019 09:43:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:22260 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727696AbfHUNn2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 21 Aug 2019 09:43:28 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7LDh6dE097345
        for <linux-rdma@vger.kernel.org>; Wed, 21 Aug 2019 09:43:26 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.93])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uh66m2waj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Wed, 21 Aug 2019 09:43:26 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Wed, 21 Aug 2019 13:43:26 -0000
Received: from us1a3-smtp02.a3.dal06.isc4sb.com (10.106.154.159)
        by smtp.notes.na.collabserv.com (10.106.227.39) with smtp.notes.na.collabserv.com ESMTP;
        Wed, 21 Aug 2019 13:43:19 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp02.a3.dal06.isc4sb.com
          with ESMTP id 2019082113431932-570646 ;
          Wed, 21 Aug 2019 13:43:19 +0000 
In-Reply-To: <b2251973c16b336c4d48e8417ce50f0c55598a9b.camel@redhat.com>
Subject: Re: Re: [PATCH for-rc] siw: fix for 'is_kva' flag issue in siw_tx_hdt()
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Doug Ledford" <dledford@redhat.com>
Cc:     "Krishnamraju Eraparaju" <krishna2@chelsio.com>, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, bharat@chelsio.com,
        nirranjan@chelsio.com
Date:   Wed, 21 Aug 2019 13:43:18 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <b2251973c16b336c4d48e8417ce50f0c55598a9b.camel@redhat.com>,<20190819111338.9366-1-krishna2@chelsio.com>
 <OFB7456B6B.E1C4D049-ON0025845B.00533DDF-0025845B.00776B49@notes.na.collabserv.com>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP55 May 22, 2019 at 11:09
X-LLNOutbound: False
X-Disclaimed: 62351
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19082113-8889-0000-0000-0000002E5D81
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.046107
X-IBM-SpamModules-Versions: BY=3.00011629; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01250009; UDB=6.00659925; IPR=6.01031563;
 MB=3.00028261; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-21 13:43:23
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-08-21 08:14:57 - 6.00010311
x-cbparentid: 19082113-8890-0000-0000-000000426705
Message-Id: <OF1D1F6B77.321AEAB1-ON0025845D.004B601C-0025845D.004B6025@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-21_04:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Doug Ledford" <dledford@redhat.com> wrote: -----

>To: "Bernard Metzler" <BMT@zurich.ibm.com>, "Krishnamraju Eraparaju"
><krishna2@chelsio.com>
>From: "Doug Ledford" <dledford@redhat.com>
>Date: 08/20/2019 07:56PM
>Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, bharat@chelsio.com,
>nirranjan@chelsio.com
>Subject: [EXTERNAL] Re: [PATCH for-rc] siw: fix for 'is_kva' flag
>issue in siw_tx_hdt()
>
>On Mon, 2019-08-19 at 21:44 +0000, Bernard Metzler wrote:
>> Hi Krishna,
>> That is a good catch. I was not aware of the possibility of mixed
>> PBL and kernel buffer addresses in one SQE.
>> 
>> A correct fix must also handle the un-mapping of any kmap()'d
>> buffers. The current TX code expects all buffers be either kmap()'d
>or
>> all not kmap()'d. So the fix is a little more complex, if we must
>> handle mixed SGL's during un-mapping. I think I can provide it by
>> tomorrow. It's almost midnight ;)
>
>I'll wait for a proper fix.  Dropping this patch.  Thanks.
>
Thanks Doug!

I have a fix ready but still have to test it with iSER. 
Unfortunately I have a hard time to test iSER with siw, since
both iSCSI-TCP target and iSER want to bind to the same
TCP port. While this may be considered a bug in that code,
siw is the first RDMA provider to take notice (since using
kernel sockets and not offloaded, hitting a TCP port
already bound).

I sent the patch to Chelsio folks and hope for
the best. They know the trick to make it working.

Thanks
Bernard.

