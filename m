Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33A461597E7
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Feb 2020 19:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbgBKSPA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 11 Feb 2020 13:15:00 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44146 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729139AbgBKSO7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 Feb 2020 13:14:59 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01BICfPX071710
        for <linux-rdma@vger.kernel.org>; Tue, 11 Feb 2020 13:14:58 -0500
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.104])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y1u9qhbsb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Tue, 11 Feb 2020 13:14:58 -0500
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Tue, 11 Feb 2020 18:14:57 -0000
Received: from us1b3-smtp08.a3dr.sjc01.isc4sb.com (10.122.203.190)
        by smtp.notes.na.collabserv.com (10.122.47.44) with smtp.notes.na.collabserv.com ESMTP;
        Tue, 11 Feb 2020 18:14:50 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp08.a3dr.sjc01.isc4sb.com
          with ESMTP id 2020021118144890-671135 ;
          Tue, 11 Feb 2020 18:14:48 +0000 
In-Reply-To: <20200210180022.GA23283@chelsio.com>
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Krishnamraju Eraparaju" <krishna2@chelsio.com>
Cc:     "Jason Gunthorpe" <jgg@mellanox.com>, dledford@redhat.com,
        linux-rdma@vger.kernel.org, bharat@chelsio.com,
        nirranjan@chelsio.com
Date:   Tue, 11 Feb 2020 18:14:48 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20200210180022.GA23283@chelsio.com>,<20200207115209.25933-1-krishna2@chelsio.com>
 <20200207141820.GF4509@mellanox.com>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP62 November 04, 2019 at 09:47
X-KeepSent: 08CE1199:B6C33AB6-0025850B:0063AEBB;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 16823
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 20021118-5525-0000-0000-000001ECAE3D
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.399202; ST=0; TS=0; UL=0; ISC=; MB=0.001919
X-IBM-SpamModules-Versions: BY=3.00012557; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000292; SDB=6.01332458; UDB=6.00709614; IPR=6.01114810;
 MB=3.00030755; MTD=3.00000008; XFM=3.00000015; UTC=2020-02-11 18:14:54
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2020-02-11 07:29:36 - 6.00010994
x-cbparentid: 20021118-5526-0000-0000-0000CC3CC235
Message-Id: <OF08CE1199.B6C33AB6-ON0025850B.0063AEBB-0025850B.00643BAC@notes.na.collabserv.com>
Subject: RE: [PATCH for-review/for-rc/for-rc] RDMA/siw: Remove unwanted WARN_ON in
 siw_cm_llp_data_ready()
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-11_05:2020-02-10,2020-02-11 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Krishnamraju Eraparaju" <krishna2@chelsio.com> wrote: -----

>To: "Jason Gunthorpe" <jgg@mellanox.com>
>From: "Krishnamraju Eraparaju" <krishna2@chelsio.com>
>Date: 02/10/2020 07:00PM
>Cc: dledford@redhat.com, bmt@zurich.ibm.com,
>linux-rdma@vger.kernel.org, bharat@chelsio.com, nirranjan@chelsio.com
>Subject: [EXTERNAL] Re: [PATCH for-review/for-rc/for-rc] RDMA/siw:
>Remove unwanted WARN_ON in siw_cm_llp_data_ready()
>
>On Friday, February 02/07/20, 2020 at 10:18:20 -0400, Jason Gunthorpe
>wrote:
>> On Fri, Feb 07, 2020 at 05:22:09PM +0530, Krishnamraju Eraparaju
>wrote:
>> > Warnings like below can fill up the dmesg while disconnecting
>RDMA
>> > connections.
>> > Hence, removing the unwanted WARN_ON.
>> 
>> Please explain why it the code is correct to take this error
>> path. Bernard clearly thought this shouldn't be happening
>> 
>> Jason
>As part of iSER multipath testcase, target(iw_cxgb4) responds with
>MPA reject
>to initiator(SIW) when iw_cxgb4 resources gets exhaused(expected as
>per
>testcase), then SIW performs the connection teardown and dissociates
>'cep' from tcp socket 'sk'. And if any "data_ready" notifications
>from
>TCP stack after this connection teardown will hit WARN_ON() in
>siw_cm_llp_data_ready().
>
>Bernard, is this WARN_ON() useful to identify any error conditions?
>
So, this WARN_ON() is wrong. It can very well happen that the socket
already got disassociated from siw, but a sockets data_ready() upcall
races with the disassociation procedure. Since we hold the
sk_callback_lock while setting or testing sk->sk_user_data,
a NULL pointer tells us this socket just got disassociated
from siw and we can bail out.
Thanks Krishna for finding that out. Your patch is correct.

Bernard.

