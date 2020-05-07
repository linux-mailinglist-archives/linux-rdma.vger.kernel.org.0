Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2A61C9966
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2020 20:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgEGSfD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 May 2020 14:35:03 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47680 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbgEGSfD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 7 May 2020 14:35:03 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 047IMPed032577;
        Thu, 7 May 2020 18:34:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=xIK/+uoiDpxic1fvsmOG8whznPgVTAV+cmLb7qDJn+k=;
 b=wMBZgv0AnHDgiCnJJF//sIWRcvIDKVhJ8v+YmGdpLKS1DWgKv1e5ltHQ0upzYaDAhRfq
 XYxxKENQLL7ZthGcAoCLLaZ1Sgdtd1nEQ42DtBLD0K2J86hz5a/vWJ9U3gnNRICSNAYc
 grIC303e3LyP2e2/NA1AFPCNlO5V8T+zhgXGGT90E7S07kTBUJl60Hx4vJKMYjsJQ+ba
 MsFdPvZC6KJWxmiTX3H3IsAoMgsin0Odirow+FqYtnqExdm2/2aH+4QyiYkAepxpA20d
 vnr0sEmuuLd684kZMTFgQw0PpamTuLR9Xu73SpFbNDtKn+lZW5VDNwqkivZKvCexqXjp Rg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 30usgq8yge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 18:34:59 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 047IGhBe141200;
        Thu, 7 May 2020 18:34:58 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 30us7r6vqu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 18:34:58 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 047IYvuk011477;
        Thu, 7 May 2020 18:34:57 GMT
Received: from ca-common-hq.us.oracle.com (/10.211.9.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 07 May 2020 11:34:57 -0700
From:   Divya Indi <divya.indi@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>, Kaike Wan <kaike.wan@intel.com>
Cc:     Gerd Rausch <gerd.rausch@oracle.com>,
        =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>,
        Rama Nichanamatlu <rama.nichanamatlu@oracle.com>,
        Doug Ledford <dledford@redhat.com>
Subject: Resolving use-after-free in ib_nl_send_msg 
Date:   Thu,  7 May 2020 11:34:46 -0700
Message-Id: <1588876487-5781-1-git-send-email-divya.indi@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9614 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 mlxlogscore=883 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005070150
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9614 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=930 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005070150
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

[PATCH] IB/sa: Resolving use-after-free in ib_nl_send_msg.

Hi,

This patch is in reply to -

https://lkml.org/lkml/2020/4/24/1076

We have a use-after-free possibility in the ibacm code path - 
when the timer(ib_nl_request_timeout) kicks in before ib_nl_snd_msg
has completed sending the query out to ibacm via netlink. The timeout 
handler ie ib_nl_request_timeout may result in releasing the query while 
ib_nl_snd_msg is still accessing query.

Since the issue appears to be specific to the ibacm code path, we are
trying to resolve it for the life cycle of sa_query in the ibacm code path.

Please review the proposed fix ie the patch that follows.

Would appreciate your thoughts and feedback on the same.

Let me know if you have any questions!

Thanks,
Divya
