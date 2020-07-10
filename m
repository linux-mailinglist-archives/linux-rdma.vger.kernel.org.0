Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A763921BB0A
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2020 18:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgGJQcd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 10 Jul 2020 12:32:33 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56154 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbgGJQcc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 10 Jul 2020 12:32:32 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06AGQiX3112546;
        Fri, 10 Jul 2020 16:32:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=ObabZAS7a0jfPiefj9R7AAIMqlwZt/9T8pbqFnKThe8=;
 b=GTWCOzjTiz6G++3IuI31SJyH4RS0G9qdx548FsF/zt2p27qrFSnArnjaYOkl5HE0e0vn
 yBqsjoKSIBOBXmohraWzx83yit2gaBYvXfl7HhL48dhX4SrCXyZN5tZf2KDNYxzz45fT
 hZi1qzFFEDZtlsx8sJkPQWe/29e+YzoKo2aiFaJYYvoUJSAwwAZgQ9nAGIhZXxp9amtH
 Ly8dHHMUN9O3TVpa4kgq5h3KLJZx1xiVnIC2MbTccwyfcdg880P3Xp40CyDGw7aofJ8E
 zXKtpkPeSCww3yvvRBqPUzIjOvyBUs+1wQNbPcdEd3R+EA4v4UK+uF5D+iiH/XyuB5y0 9g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 325y0argcf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 10 Jul 2020 16:32:31 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06AGTPgs060160;
        Fri, 10 Jul 2020 16:32:30 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 325k3km451-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Jul 2020 16:32:30 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06AGWT03004598;
        Fri, 10 Jul 2020 16:32:29 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 10 Jul 2020 09:32:29 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.14\))
Subject: Re: [PATCH RFC 0/3] IB CM tracepoints
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200710151737.GZ25301@ziepe.ca>
Date:   Fri, 10 Jul 2020 12:32:28 -0400
Cc:     linux-rdma@vger.kernel.org, aron.silverton@oracle.com
Content-Transfer-Encoding: 7bit
Message-Id: <1CE2FD8B-8A27-4623-ABA0-D7E830E83D7D@oracle.com>
References: <20200710135812.14749.4630.stgit@klimt.1015granger.net>
 <20200710151737.GZ25301@ziepe.ca>
To:     Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: Apple Mail (2.3445.104.14)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9678 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 mlxscore=0
 spamscore=0 malwarescore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007100110
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9678 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0
 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007100110
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On Jul 10, 2020, at 11:17 AM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> 
> On Fri, Jul 10, 2020 at 10:06:01AM -0400, Chuck Lever wrote:
>> Hi-
>> 
>> This is a Request For Comments.
>> 
>> Oracle has an interest in a common observability infrastructure in
>> the RDMA core and ULPs. One alternative for this infrastructure is
>> to introduce static tracepoints that can also be used as hooks for
>> eBPF scripts, replacing infrastructure that is based on printk.
> 
> Don't we already have tracepoints in CM, why is adding more RFC?

One of these patches _replaces_ printk calls with tracepoints.
Is that OK?

--
Chuck Lever



