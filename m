Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7CDE92327
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2019 14:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfHSMLy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Aug 2019 08:11:54 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33102 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbfHSMLy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 19 Aug 2019 08:11:54 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7JC97kU047500;
        Mon, 19 Aug 2019 12:11:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=u8unIYQ7i2zWreioTHfGDdMWESRTBoBKE3x7Aei6fxU=;
 b=Jh5HfbAXgpjhY3jDMUOna/448TQOaCcGUZDqELI2AZgoilxCFLpDW7T53MFTwL7T1Trg
 1eWnqP8YJgd5CR0LFT2I24uob3wL3MmSNRKehKdCKrXyjbfEYnr21MYF4aYQ4xi/27y5
 iPCKKw4buTpg1qKrAD/7SdBR5w/5RcSLHpkh0G4xRO7U6C0t838g3mjeGaBaCymw0ndG
 XEBXCnp8+1jcE1V2EZvKWSNMcmI3rozCtZSQG72sZJwtWG7ViJkEsBl2UvoUEivInLBB
 ILx57JVbluRKJGp0SpqNMBhLGTHfkHkkcXFkfgGwV0W4hIJTVY6LDXXJm1aABJ8b6DL0 Xw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2ue9hp7170-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Aug 2019 12:11:51 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7JC7cuk144093;
        Mon, 19 Aug 2019 12:09:50 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2ufb46pa01-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Aug 2019 12:09:50 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7JC9nC8003588;
        Mon, 19 Aug 2019 12:09:49 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 19 Aug 2019 05:09:48 -0700
Date:   Mon, 19 Aug 2019 15:09:43 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     bmt@zurich.ibm.com
Cc:     linux-rdma@vger.kernel.org
Subject: [bug report] rdma/siw: connection management
Message-ID: <20190819120943.GA27514@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9353 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=769
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908190140
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9353 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=829 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908190140
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello Bernard Metzler,

This is a semi-automatic email about new static checker warnings.

The patch 6c52fdc244b5: "rdma/siw: connection management" from Jun
20, 2019, leads to the following Smatch complaint:

    drivers/infiniband/sw/siw/siw_cm.c:1518 siw_connect()
    error: we previously assumed 'qp' could be null (see line 1372)

drivers/infiniband/sw/siw/siw_cm.c
  1371		qp = siw_qp_id2obj(sdev, params->qpn);
  1372		if (!qp) {
                    ^^^
NULL

  1373			WARN(1, "[QP %u] does not exist\n", params->qpn);
  1374			rv = -EINVAL;
  1375			goto error;
                        ^^^^^^^^^^

  1376		}
  1377		if (v4)
  1378			siw_dbg_qp(qp,

[ snip ]

  1508		if (rv >= 0) {
  1509			rv = siw_cm_queue_work(cep, SIW_CM_WORK_MPATIMEOUT);
  1510			if (!rv) {
  1511				siw_dbg_cep(cep, "id 0x%p, [QP %u]: exit\n", id,
  1512					    qp_id(qp));
  1513				siw_cep_set_free(cep);
  1514				return 0;
  1515			}
  1516		}
  1517	error:
  1518		siw_dbg_qp(qp, "failed: %d\n", rv);
                           ^^
NULL dereference.

  1519	
  1520		if (cep) {

regards,
dan carpenter
