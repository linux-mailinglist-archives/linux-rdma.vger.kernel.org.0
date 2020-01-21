Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16D741436BE
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Jan 2020 06:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbgAUFdF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Jan 2020 00:33:05 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:34008 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgAUFdC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 21 Jan 2020 00:33:02 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00L5VkQt091493;
        Tue, 21 Jan 2020 05:32:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=4mz38snHU/i0JPkzXMl1PdkExdfPdTaJ/iDVmnNO2dk=;
 b=nvjJWaoORLz+6GEfxvlvTjnBAG8vqCJEfi1H/pYgnb1Ll/c2SDK1OyVow3pvKu5SuZq5
 ha9dRGR242RccD8nkYL1KBHyd0bzvqliU1cbOkEFh/4pMwdnRewvp+2O2LllPEa7y/Zp
 U3hEEFfqbrseIHR/BYzIZKaDfqnVXv5kINop6NXcYM+sSmwC3gOHEYoAcCc0Rh0aT0vD
 nGunJ5krwthTt1gsRHcpT8DYw0BslYZbxeiE54ew82M5iBzhY1zB0k9JwHUEkCHV0GzZ
 QGO4XIaEZ4M4FWJKJAcoyS+AoSTzzmtxMTypdtVN7qxQ8WgNeUGJnKqtcxzN0BhOeW7s Xg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2xksyq2jg2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jan 2020 05:32:59 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00L5OAvJ101956;
        Tue, 21 Jan 2020 05:30:59 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2xnpfnak4p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jan 2020 05:30:59 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00L5Utqb016146;
        Tue, 21 Jan 2020 05:30:56 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 20 Jan 2020 21:30:55 -0800
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        target-devel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Rahul Kundu <rahul.kundu@chelsio.com>
Subject: Re: [PATCH] RDMA/isert: Fix a recently introduced regression related to logout
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20200116044737.19507-1-bvanassche@acm.org>
Date:   Tue, 21 Jan 2020 00:30:53 -0500
In-Reply-To: <20200116044737.19507-1-bvanassche@acm.org> (Bart Van Assche's
        message of "Wed, 15 Jan 2020 20:47:37 -0800")
Message-ID: <yq1d0bdidf6.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9506 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=842
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001210047
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9506 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=920 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001210048
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


Bart,

> iscsit_close_connection() calls isert_wait_conn(). Due to commit
> e9d3009cb936 both functions call target_wait_for_sess_cmds() although
> that last function should be called only once. Fix this by removing
> the target_wait_for_sess_cmds() call from isert_wait_conn() and by
> only calling isert_wait_conn() after target_wait_for_sess_cmds().

Applied to 5.5/scsi-fixes, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
