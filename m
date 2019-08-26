Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDE3E9CFE2
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Aug 2019 14:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732083AbfHZM44 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Aug 2019 08:56:56 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41392 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732082AbfHZM44 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 26 Aug 2019 08:56:56 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7QCsHCZ112399;
        Mon, 26 Aug 2019 12:56:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=evmC9BIm3CcBRO6yaMqxC7XnkfZ9l6H7T7ohzmil+oI=;
 b=Gu3E8NFZNGyshYhznI17dtqXYfVXJGKtCpzYHcPP8UGpKM4DWFVBL3svIonDR1o6xbe1
 fhsb9NX+e1O4mjASL95cMCgcaXPx0IG9bH7o8XSHT2bmOo5amFaAPjjcoC2EapnQwnko
 +6WrX3XzQ1Fq7W3L7mPXp9PDQYZvfkajvsophnEnc2GMQ0irbv1+BM+JXE9kGjv7dfBj
 /K7NABrW1En9IhKPKqLrsMBlx28MwQnSPO4EBv78osvvp2aB4psG+cCYH8GSuFCgL+N6
 SW5dhShAFV5XFrHcQPyzJn/wtL9SNo690WuTyDFfQRNJ6YQ3eudmjgMk3ZXT+7uE65ka Xw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2ujw700wtn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Aug 2019 12:56:52 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7QCsHhS114229;
        Mon, 26 Aug 2019 12:56:52 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2ujw6cad08-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Aug 2019 12:56:51 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7QCup8j027804;
        Mon, 26 Aug 2019 12:56:51 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 26 Aug 2019 05:56:50 -0700
Date:   Mon, 26 Aug 2019 15:56:45 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     eranbe@mellanox.com
Cc:     linux-rdma@vger.kernel.org
Subject: [bug report] net/mlx5e: Add mlx5e HV VHCA stats agent
Message-ID: <20190826125645.GA32067@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9360 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=873
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908260140
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9360 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=936 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908260140
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello Eran Ben Elisha,

The patch cef35af34d6d: "net/mlx5e: Add mlx5e HV VHCA stats agent"
from Aug 22, 2019, leads to the following static checker warning:

	drivers/net/ethernet/mellanox/mlx5/core/en/hv_vhca_stats.c:41 mlx5e_hv_vhca_fill_stats()
	warn: potential pointer math issue ('buf' is a u64 pointer)

drivers/net/ethernet/mellanox/mlx5/core/en/hv_vhca_stats.c
    33  static void mlx5e_hv_vhca_fill_stats(struct mlx5e_priv *priv, u64 *data,
                                                                      ^^^^^^^^^
data is a u64 pointer.

    34                                       int buf_len)
    35  {
    36          int ch, i = 0;
    37  
    38          for (ch = 0; ch < priv->max_nch; ch++) {
    39                  u64 *buf = data + i;
                        ^^^^^^^^

    40  
    41                  if (WARN_ON_ONCE(buf +
    42                                   sizeof(struct mlx5e_hv_vhca_per_ring_stats) >
                                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This pointer math doesn't work.  I'm surprised the warning doesn't
trigger.

    43                                   data + buf_len))
    44                          return;
    45  
    46                  mlx5e_hv_vhca_fill_ring_stats(priv, ch,
    47                                                (struct mlx5e_hv_vhca_per_ring_stats *)buf);
                                                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
If we made both "data" and "buf" void pointers then this would be
much easier and the casting could be removed.


    48                  i += sizeof(struct mlx5e_hv_vhca_per_ring_stats) / sizeof(u64);
                             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This math works, but it's so complicated and you have to verify that
mlx5e_hv_vhca_per_ring_stats % sizeof(u64) is zero.

    49          }
    50  }

regards,
dan carpenter
