Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A91C628AFFC
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Oct 2020 10:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgJLIUx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Oct 2020 04:20:53 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:43862 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbgJLIUx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Oct 2020 04:20:53 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09C8KCvj063963;
        Mon, 12 Oct 2020 08:20:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=Ld1ufa35zMZlHlBYaq+caM0gAYVAf17FAexNWwG58CQ=;
 b=OpK/7ld/K4TQpiyX7Xq825LLLLTjiL8pajsZd9Zl/a9YOFSxWbP8DwtauBrdsMTQNS0y
 10EgVRaSyeVGUKIGMD9956UvhQEcOFiZj8g3jQs8ep5EgTkfKytbd8qAVXjgMXGQL7xe
 rGK28/A2zI169yC8/8C3/5pqCfv6ZiAU13gZZatmqeDt1RiJJI+u+y9v3LCUdmgNtokZ
 DtmfYM2H46SUe8SX9CCHuzz8W3GWaTkrYFu8SO8nAJCcpVUTmQpmSTmYJteEe1EIszJH
 hQRLp61W2yK2Xx+lrDgJnu+ixy9uKH5U01oKTD9Bi3aHVpCH2s3a+yj+RhY+MyIHCa5u /g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 3434wkbvtr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 12 Oct 2020 08:20:49 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09C8FZ65078298;
        Mon, 12 Oct 2020 08:20:49 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 343phkhg1u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Oct 2020 08:20:49 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09C8KmL6030131;
        Mon, 12 Oct 2020 08:20:48 GMT
Received: from [10.159.211.29] (/10.159.211.29)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 12 Oct 2020 01:20:48 -0700
Subject: Re: RDMA subsystem namespace related questions (was Re: Finding the
 namespace of a struct ib_device)
To:     Jason Gunthorpe <jgg@ziepe.ca>, Chuck Lever <chucklever@gmail.com>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
References: <20201008103641.GM13580@unreal>
 <aec6906d-7be5-b489-c7dc-0254c4538723@oracle.com>
 <20201008160814.GF5177@ziepe.ca>
 <727de097-4338-c1d8-73a0-1fce0854f8af@oracle.com>
 <20201009143940.GT5177@ziepe.ca>
 <0E82FB51-244C-4134-8F74-8C365259DCD5@gmail.com>
 <20201009145706.GU5177@ziepe.ca>
 <EC7EE276-3529-4374-9F90-F061AAC3B952@gmail.com>
 <20201009150758.GV5177@ziepe.ca>
 <7EC25CA9-27B5-4900-B49C-43D29ED06EB6@gmail.com>
 <20201009153406.GA5177@ziepe.ca>
From:   Ka-Cheong Poon <ka-cheong.poon@oracle.com>
Organization: Oracle Corporation
Message-ID: <4e630f85-c684-1e56-bb68-22c37872c728@oracle.com>
Date:   Mon, 12 Oct 2020 16:20:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201009153406.GA5177@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9771 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010120072
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9771 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 mlxscore=0
 malwarescore=0 phishscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 bulkscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010120072
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/9/20 11:34 PM, Jason Gunthorpe wrote:

> Yes, because namespaces are fundamentally supposed to be anchored in
> the processes inside the namespace.
> 
> Having the kernel jump in and start opening holes as soon as a
> namespace is created is just wrong.
> 
> At a bare minimum the listener should not exist until something in the
> namespace is willing to work with RDS.


As I mentioned in a previous email, starting is not the problem.  It
is the problem of deleting a namespace.  Using what is suggested
above, it means that there needs to be an explicit shutdown in
addition to the normal shutdown of a namespace.  It is not clear why
this is necessary.  The additional reference by rdma_create_id() puts
an unnecessary restriction on what a kernel module can do.  Without
this reference, if a kernel module wants to use, say a one-to-one/many
mapping model to user space socket as suggested above, it can do that.
And if a kernel module does not want to use this model, it can also
choose to do that.  It is not clear why such a restriction must be
enforced in RDMA subsystem while there is no such restriction using
kernel socket.


-- 
K. Poon
ka-cheong.poon@oracle.com


