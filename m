Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 649A914AB9F
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Jan 2020 22:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgA0V15 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Jan 2020 16:27:57 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:32982 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgA0V15 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 27 Jan 2020 16:27:57 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00RLDIlj130990;
        Mon, 27 Jan 2020 21:27:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=XrnUcCVNFN17K1njViqRv7tgM4wfz2c1O5WPjccI1qw=;
 b=iA3XmnXdxd8C3Ulw22+evX4e0Dg4dMbkXYQEnFpxzdCJQ6dZvbnxVmAfn2W0Wxot2Utz
 Xc76dDWMPeV78H/wF6D/ioB+ZjCXBSNUX2yH4taGtvpBMMPJfidpziek5ZUFrAM0XZOg
 hJJk4EP7vn4fo4uy3ACCeFmls5D1lQAa/9s/Y80H5BGl/DIevdpZjltdCYgK5K8q6LBa
 jDmz9/5+W3a/btl0CIIokjEaPxCuw7zDcwrcV9i8uJOM5VtTWfjpxrqKBHi1yYzB+vSk
 a/5rRsK16TDyBpH88fvtj6QCD2u6s8Z0RBloe3jqwgIyefuzfQLjyCbDyIzp42msy5kT Nw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2xrd3u28dw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jan 2020 21:27:51 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00RLDNtt023603;
        Mon, 27 Jan 2020 21:25:51 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2xry4v6uuh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jan 2020 21:25:50 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00RLPnXR025698;
        Mon, 27 Jan 2020 21:25:50 GMT
Received: from [10.211.47.126] (/10.211.47.126)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 27 Jan 2020 13:25:49 -0800
Subject: Re: [PATCH] IB/mlx4: Fix use after free in RDMA CM disconnect code
 path
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     haakon.bugge@oracle.com, rama.nichanamatlu@oracle.com,
        yishaih@mellanox.com, linux-rdma@vger.kernel.org, leon@kernel.org
References: <1580156212-28267-1-git-send-email-manjunath.b.patil@oracle.com>
 <20200127205001.GA21215@ziepe.ca>
From:   Manjunath Patil <manjunath.b.patil@oracle.com>
Organization: Oracle Corporation
Message-ID: <1ec3cfb2-7a8b-3ae0-f18b-9c8aa0206418@oracle.com>
Date:   Mon, 27 Jan 2020 13:25:48 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200127205001.GA21215@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9513 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=766
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001270168
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9513 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=829 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001270168
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Thank you.

-Manjunath
On 1/27/2020 12:50 PM, Jason Gunthorpe wrote:
> On Mon, Jan 27, 2020 at 12:16:52PM -0800, Manjunath Patil wrote:
>> PS:
>> This fixes the recently submitted patch from Haakon[cc'd]
>> The commit hash used in here has to be updated while applying
>> Commit 01528b332860 ("IB/mlx4: Fix leak in id_map_find_del") introduces
>> two code paths that can pontentially cause use after free.
> Okay, I squished this into the original patch
>
> Thanks,
> Jason

