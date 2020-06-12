Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD6611F7E2F
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2020 22:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgFLUrp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Jun 2020 16:47:45 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:44950 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgFLUrp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 12 Jun 2020 16:47:45 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05CKgwvj078593;
        Fri, 12 Jun 2020 20:47:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=RIx9xoq5Wc3f9je9p4C2sXvqY59EhXWHuC2I1X0U2ps=;
 b=zcWJShVbjIIfpz287NurYH9ZzXS7BtQTt4Do9MnqXfCNzalhNXYuH8ANHufuYomKlDr/
 EZEMJNN3UCG0yn7+oHIN0lHuo2EPPKF1EXZEpghfsrJR6HwbrrXUFGgrfulnL46h9mH/
 oImGhhPwmiVvwIDZcBN2+J5FhaQWepdEPDxEKhhSOPF5tczONVObSAb/EsEqK8JP3YZS
 A6KMeRWG1qV+R0m+4G0LctV8EQSa+PeZPsrXxSdV9SpIAFgnyzOizADhmAK+/0K1GR4X
 HFT2m9dtI2XtTbp1yCG39jjx94GFxytmNPWtaRfQPx40ZJ1JaTmidnIiI4TJducu8TnQ EA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 31jepp8rga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 12 Jun 2020 20:47:38 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05CKjD9K036244;
        Fri, 12 Jun 2020 20:47:37 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 31mh15r316-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jun 2020 20:47:37 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 05CKiuaL000346;
        Fri, 12 Jun 2020 20:44:56 GMT
Received: from ib0.gerd.us.oracle.com (/10.211.52.79)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 12 Jun 2020 13:44:56 -0700
Subject: Re: [PATCH 2.6.26-4.14] IB/ipoib: Arm "send_cq" to process
 completions in due time
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>,
        Doug Ledford <dledford@redhat.com>,
        Sean Hefty <sean.hefty@intel.com>,
        Hal Rosenstock <hal.rosenstock@gmail.com>,
        linux-rdma@vger.kernel.org
References: <322533b0-17de-b6b2-7da4-f99c7dfce3a8@oracle.com>
 <20200612195511.GA6578@ziepe.ca>
From:   Gerd Rausch <gerd.rausch@oracle.com>
Message-ID: <631c9e79-34e8-cc89-99bc-11fd6bc929e4@oracle.com>
Date:   Fri, 12 Jun 2020 13:44:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200612195511.GA6578@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9650 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006120151
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9650 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 malwarescore=0 mlxscore=0 cotscore=-2147483648 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006120151
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason,

On 12/06/2020 12.55, Jason Gunthorpe wrote:
> On Fri, Jun 12, 2020 at 12:41:16PM -0700, Gerd Rausch wrote:
>> This issue appears to no longer exist in Linux-4.15
>> and younger, because the following commit does
>> call "ib_req_notify_cq" on "send_cq":
>> 8966e28d2e40c ("IB/ipoib: Use NAPI in UD/TX flows")
> 
> I'm not really clear what you want to happen to this patch - are you
> proposing a stable patch that is not just a backport? Why can't you
> backport the fix above instead?

I considered backporting commit 8966e28d2e40c ("IB/ipoib: Use NAPI in UD/TX flows")
with all the dependencies it may have a considerably higher risk
than just arming the TX CQ.

> 
> You'll need to follow everything in
> 
> Documentation/process/stable-kernel-rules.rst
> 
> Or the stable maintainers won't even look at this.
> 

Thanks,

  Gerd

