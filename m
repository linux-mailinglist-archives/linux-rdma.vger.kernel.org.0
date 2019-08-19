Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABB92925C1
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2019 16:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfHSOCw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 19 Aug 2019 10:02:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:1774 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727352AbfHSOCw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 19 Aug 2019 10:02:52 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7JDuo2l086096
        for <linux-rdma@vger.kernel.org>; Mon, 19 Aug 2019 10:02:51 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.91])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ufuf1cpga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Mon, 19 Aug 2019 10:02:51 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Mon, 19 Aug 2019 14:02:50 -0000
Received: from us1a3-smtp02.a3.dal06.isc4sb.com (10.106.154.159)
        by smtp.notes.na.collabserv.com (10.106.227.143) with smtp.notes.na.collabserv.com ESMTP;
        Mon, 19 Aug 2019 14:02:47 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp02.a3.dal06.isc4sb.com
          with ESMTP id 2019081914024669-570198 ;
          Mon, 19 Aug 2019 14:02:46 +0000 
In-Reply-To: <20190819120943.GA27514@mwanda>
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Dan Carpenter" <dan.carpenter@oracle.com>
Cc:     linux-rdma@vger.kernel.org
Date:   Mon, 19 Aug 2019 14:02:47 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20190819120943.GA27514@mwanda>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP55 May 22, 2019 at 11:09
X-LLNOutbound: False
X-Disclaimed: 57139
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19081914-2475-0000-0000-000000616FAD
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.000002
X-IBM-SpamModules-Versions: BY=3.00011618; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01249088; UDB=6.00659360; IPR=6.01030615;
 MB=3.00028231; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-19 14:02:49
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-08-19 13:57:58 - 6.00010304
x-cbparentid: 19081914-2476-0000-0000-00002B5F7AF5
Message-Id: <OFF4B5F90A.4B8AD913-ON0025845B.004D28B6-0025845B.004D28BD@notes.na.collabserv.com>
Subject: Re:  [bug report] rdma/siw: connection management
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-19_03:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Dan Carpenter" <dan.carpenter@oracle.com> wrote: -----

>To: bmt@zurich.ibm.com
>From: "Dan Carpenter" <dan.carpenter@oracle.com>
>Date: 08/19/2019 02:12PM
>Cc: linux-rdma@vger.kernel.org
>Subject: [EXTERNAL] [bug report] rdma/siw: connection management
>
>Hello Bernard Metzler,
>
>This is a semi-automatic email about new static checker warnings.
>
>The patch 6c52fdc244b5: "rdma/siw: connection management" from Jun
>20, 2019, leads to the following Smatch complaint:
>
>    drivers/infiniband/sw/siw/siw_cm.c:1518 siw_connect()
>    error: we previously assumed 'qp' could be null (see line 1372)
>
>drivers/infiniband/sw/siw/siw_cm.c
>  1371		qp = siw_qp_id2obj(sdev, params->qpn);
>  1372		if (!qp) {
>                    ^^^
>NULL
>
>  1373			WARN(1, "[QP %u] does not exist\n", params->qpn);
>  1374			rv = -EINVAL;
>  1375			goto error;
>                        ^^^^^^^^^^
>
>  1376		}
>  1377		if (v4)
>  1378			siw_dbg_qp(qp,
>
>[ snip ]
>
>  1508		if (rv >= 0) {
>  1509			rv = siw_cm_queue_work(cep, SIW_CM_WORK_MPATIMEOUT);
>  1510			if (!rv) {
>  1511				siw_dbg_cep(cep, "id 0x%p, [QP %u]: exit\n", id,
>  1512					    qp_id(qp));
>  1513				siw_cep_set_free(cep);
>  1514				return 0;
>  1515			}
>  1516		}
>  1517	error:
>  1518		siw_dbg_qp(qp, "failed: %d\n", rv);
>                           ^^
>NULL dereference.
>
>  1519	
>  1520		if (cep) {
>

Thanks Dan!

A patch is on its way...

Bernard.

>regards,
>dan carpenter
>
>

