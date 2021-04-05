Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A975353BCF
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Apr 2021 07:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbhDEFmH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Apr 2021 01:42:07 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35882 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbhDEFmH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 5 Apr 2021 01:42:07 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1355eOaZ163506;
        Mon, 5 Apr 2021 05:41:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=zhQnU1H76pQydnrWceIR1dWht8pjhp9lgvgfUU17rZk=;
 b=hZ9fg2d/jbfYDtygTwS0HxRummCv7YyDdEGHS9sJPJ6iOWnPoljWkhJfTREpSB1VVqfv
 uL/3ybgWf29gHyAMuuJYPXRdq6q9kUvGuAtg6lSSd1fhI2M60vEkG8K04FKdvoYDYRIm
 ACpClrhIP1zQjgBXgm2TxnJv6eNx4WaIT+uLLVM+TBQIY+tTzq+W3I4G40PVSLRtYBWr
 EtVJ8p9POF1rRS9UZcl1CG5wOp27EDTah+GulyZFm87SHXnhBSkIa2w/XXO2X1nWE8U2
 UI52QcwVc3igDwgUtTezbJl1CessEIfrIUv3cdryAkzMoYY4b2l+TFOdwnJR2umcD/GC AQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 37q3f2954j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Apr 2021 05:41:53 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1355Znge043085;
        Mon, 5 Apr 2021 05:41:51 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 37qa3gmf31-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Apr 2021 05:41:51 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 1355foCR013859;
        Mon, 5 Apr 2021 05:41:50 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 04 Apr 2021 22:41:49 -0700
Date:   Mon, 5 Apr 2021 08:41:41 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Mark Bloch <mbloch@nvidia.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mark Bloch <markb@mellanox.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RDMA/addr: potential uninitialized variable in
 ib_nl_process_good_ip_rsep()
Message-ID: <20210405054140.GY2065@kadam>
References: <YGcES6MsXGnh83qi@mwanda>
 <YGmWB4fT/8IFeiZf@unreal>
 <1b21be94-bf14-9e73-68a3-c503bb79f683@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b21be94-bf14-9e73-68a3-c503bb79f683@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9944 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 spamscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104030000 definitions=main-2104050039
X-Proofpoint-GUID: 4js-rib4bKev7qwXlr0Fk96v6RAhdNbd
X-Proofpoint-ORIG-GUID: 4js-rib4bKev7qwXlr0Fk96v6RAhdNbd
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9944 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 suspectscore=0
 spamscore=0 impostorscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 lowpriorityscore=0 clxscore=1011 priorityscore=1501 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104030000
 definitions=main-2104050039
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Could you send that and give me a reported-by?  I'm going AFK for a
week.

regards,
dan carpenter

