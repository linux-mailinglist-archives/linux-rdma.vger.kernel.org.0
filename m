Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC68776073
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jul 2019 10:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbfGZILH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 26 Jul 2019 04:11:07 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:39554 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbfGZILG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 26 Jul 2019 04:11:06 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6Q89B62190146;
        Fri, 26 Jul 2019 08:11:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=gQdHuEke+yBenm96UqVGbsHuxiHJcndcY+qMXMTpilc=;
 b=FRlNbmvQyKLSDPtyUsm3bPE4dWKIgvuRapMv8TL7ZFzqGgTxmBOyXlrIhIXJz/MlHfbV
 8eynX+Vbuwyhn/BrjoArxihVHRs77BNi5KjKsrTvLxy1yvr2C4E/p+n4Bb+im7MAIiml
 2vhIKjOIJTRD1ON65VAnjuSrMttsRQpymd9p+HnNAItrGCPj//yDD6tCIU77m1HhKX55
 ZfvAjQidPikxRRQZt5oOseZ0NzHP/2Nu68ofSnhT/DhYJfjzmHJ+vE3vFsivQQ4KsKtX
 XaVVMZioYBrGwR5fV3y/CeW96U1tXvPmLgGmosz1p+Mzb4yzY7EEzAjm5e+PXrHAuIDV 3A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2tx61c8nc9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Jul 2019 08:11:03 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6Q882TO165221;
        Fri, 26 Jul 2019 08:11:03 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2tyd3p88cb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Jul 2019 08:11:03 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6Q8B2ao029056;
        Fri, 26 Jul 2019 08:11:02 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 26 Jul 2019 01:11:01 -0700
Date:   Fri, 26 Jul 2019 11:10:56 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     bmt@zurich.ibm.com
Cc:     linux-rdma@vger.kernel.org
Subject: [bug report] rdma/siw: queue pair methods
Message-ID: <20190726081056.GA27059@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9329 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=676
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907260104
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9329 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=720 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907260105
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello Bernard Metzler,

The patch f29dd55b0236: "rdma/siw: queue pair methods" from Jun 20,
2019, leads to the following static checker warning:

	drivers/infiniband/sw/siw/siw_qp.c:226 siw_qp_enable_crc()
	warn: variable dereferenced before check 'siw_crypto_shash' (see line 223)

drivers/infiniband/sw/siw/siw_qp.c
   219  static int siw_qp_enable_crc(struct siw_qp *qp)
   220  {
   221          struct siw_rx_stream *c_rx = &qp->rx_stream;
   222          struct siw_iwarp_tx *c_tx = &qp->tx_ctx;
   223          int size = crypto_shash_descsize(siw_crypto_shash) +
                                                 ^^^^^^^^^^^^^^^^
Dereferenced inside function.

   224                          sizeof(struct shash_desc);
   225  
   226          if (siw_crypto_shash == NULL)
                    ^^^^^^^^^^^^^^^^^^^^^^^^
Checked too late.

   227                  return -ENOENT;
   228  
   229          c_tx->mpa_crc_hd = kzalloc(size, GFP_KERNEL);
   230          c_rx->mpa_crc_hd = kzalloc(size, GFP_KERNEL);
   231          if (!c_tx->mpa_crc_hd || !c_rx->mpa_crc_hd) {
   232                  kfree(c_tx->mpa_crc_hd);
   233                  kfree(c_rx->mpa_crc_hd);
   234                  c_tx->mpa_crc_hd = NULL;
   235                  c_rx->mpa_crc_hd = NULL;
   236                  return -ENOMEM;
   237          }
   238          c_tx->mpa_crc_hd->tfm = siw_crypto_shash;
   239          c_rx->mpa_crc_hd->tfm = siw_crypto_shash;
   240  
   241          return 0;
   242  }

regards,
dan carpenter
