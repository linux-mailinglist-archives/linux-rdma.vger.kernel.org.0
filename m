Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8B901F3FB8
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jun 2020 17:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730870AbgFIPom (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 9 Jun 2020 11:44:42 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:46518 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728903AbgFIPol (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 9 Jun 2020 11:44:41 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 059FaxxL057615;
        Tue, 9 Jun 2020 15:44:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=GC6aPT5hAt4URZMa3rOo5BoBeN+vVqf9KIXgG4/G2fA=;
 b=I08Q47WFZ3i5Blm491cA3QLwvA/AGXX6COgYK0oGzOF5GSf3af5wu57xQD5PoFPBHgHQ
 P73V5lsUhXGxuG+CwwD6gCUSgN3PpqAHzmWcwCrispdHlsSMlhn+XAh3ZT4B0jJGw+Yw
 csuLKtjngPavbXzNM6ZXV5HxgMAyog/frDdeK2OG+eCjW8PpELlB0hxRA2v7DQjlIV4z
 NCmUePZhmjvomx3AExA6OlmQhK5dy/JBwbmXRPyhwKj31Nr+pEheMqMdaYPxNpVbc3Al
 zoUl3NcuRUYSOhgbXGqODgrKXfSpPtHhRxD/QN8/PHAs5wEYTjxOPPKIwnLeKZE3ICMe zQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 31g33m5hy1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 09 Jun 2020 15:44:36 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 059FbtpF069165;
        Tue, 9 Jun 2020 15:44:36 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 31gn2wweu8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Jun 2020 15:44:36 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 059FiYeK019014;
        Tue, 9 Jun 2020 15:44:35 GMT
Received: from dhcp-10-159-155-165.vpn.oracle.com (/10.159.155.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 09 Jun 2020 08:44:34 -0700
Subject: Re: Review Request
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kaike Wan <kaike.wan@intel.com>,
        Gerd Rausch <gerd.rausch@oracle.com>,
        =?UTF-8?Q?H=c3=a5kon_Bugge?= <haakon.bugge@oracle.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>,
        Rama Nichanamatlu <rama.nichanamatlu@oracle.com>,
        Doug Ledford <dledford@redhat.com>
References: <1591627576-920-1-git-send-email-divya.indi@oracle.com>
 <20200609070352.GK164174@unreal>
From:   Divya Indi <divya.indi@oracle.com>
Message-ID: <c4a8fffe-b963-7627-7f39-a14b16dbe312@oracle.com>
Date:   Tue, 9 Jun 2020 08:44:32 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200609070352.GK164174@unreal>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9647 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 mlxlogscore=943 spamscore=0 suspectscore=11
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006090118
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9647 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=11 adultscore=0
 spamscore=0 cotscore=-2147483648 malwarescore=0 phishscore=0 mlxscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 mlxlogscore=973 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006090118
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Thanks Leon, Noted!

On 6/9/20 12:03 AM, Leon Romanovsky wrote:
> On Mon, Jun 08, 2020 at 07:46:15AM -0700, Divya Indi wrote:
>> [PATCH v3] IB/sa: Resolving use-after-free in ib_nl_send_msg
>>
>> Hi,
>>
>> Please review the patch that follows.
> Please read Documentation/process/submitting-patches.rst
> 14) The canonical patch format
>
> You don't need an extra email "Review request" and Changelog should be
> put inside the patch itself under "---" marker.
>
> Thanks
