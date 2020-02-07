Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA96155A5A
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2020 16:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgBGPHq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Fri, 7 Feb 2020 10:07:46 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44188 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726901AbgBGPHq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Feb 2020 10:07:46 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 017F77od027123
        for <linux-rdma@vger.kernel.org>; Fri, 7 Feb 2020 10:07:45 -0500
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.90])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y0ktsk2nc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Fri, 07 Feb 2020 10:07:45 -0500
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Fri, 7 Feb 2020 15:07:44 -0000
Received: from us1a3-smtp06.a3.dal06.isc4sb.com (10.146.103.243)
        by smtp.notes.na.collabserv.com (10.106.227.141) with smtp.notes.na.collabserv.com ESMTP;
        Fri, 7 Feb 2020 15:07:39 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp06.a3.dal06.isc4sb.com
          with ESMTP id 2020020715073811-531808 ;
          Fri, 7 Feb 2020 15:07:38 +0000 
In-Reply-To: <20200207141820.GF4509@mellanox.com>
Subject: Re: Re: [PATCH for-review/for-rc/for-rc] RDMA/siw: Remove unwanted WARN_ON
 in siw_cm_llp_data_ready()
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Jason Gunthorpe" <jgg@mellanox.com>
Cc:     "Krishnamraju Eraparaju" <krishna2@chelsio.com>,
        dledford@redhat.com, linux-rdma@vger.kernel.org,
        bharat@chelsio.com, nirranjan@chelsio.com
Date:   Fri, 7 Feb 2020 15:07:38 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20200207141820.GF4509@mellanox.com>,<20200207115209.25933-1-krishna2@chelsio.com>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP62 November 04, 2019 at 09:47
X-LLNOutbound: False
X-Disclaimed: 26023
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 20020715-3649-0000-0000-0000021F8D29
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.000057
X-IBM-SpamModules-Versions: BY=3.00012531; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000292; SDB=6.01330495; UDB=6.00708439; IPR=6.01112836;
 MB=3.00030690; MTD=3.00000008; XFM=3.00000015; UTC=2020-02-07 15:07:44
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2020-02-07 10:46:08 - 6.00010979
x-cbparentid: 20020715-3650-0000-0000-00004F14B9F5
Message-Id: <OF5BC0211E.2519BE49-ON00258507.00530E34-00258507.005318C2@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-07_01:2020-02-07,2020-02-07 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Jason Gunthorpe" <jgg@mellanox.com> wrote: -----

>To: "Krishnamraju Eraparaju" <krishna2@chelsio.com>
>From: "Jason Gunthorpe" <jgg@mellanox.com>
>Date: 02/07/2020 03:18PM
>Cc: dledford@redhat.com, bmt@zurich.ibm.com,
>linux-rdma@vger.kernel.org, bharat@chelsio.com, nirranjan@chelsio.com
>Subject: [EXTERNAL] Re: [PATCH for-review/for-rc/for-rc] RDMA/siw:
>Remove unwanted WARN_ON in siw_cm_llp_data_ready()
>
>On Fri, Feb 07, 2020 at 05:22:09PM +0530, Krishnamraju Eraparaju
>wrote:
>> Warnings like below can fill up the dmesg while disconnecting RDMA
>> connections.
>> Hence, removing the unwanted WARN_ON.
>
>Please explain why it the code is correct to take this error
>path. Bernard clearly thought this shouldn't be happening
>
>Jason
>
>
I have to look into it as well. It's maybe on me revising my
thoughts.

Thanks,
Bernard.

