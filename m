Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32D92297F54
	for <lists+linux-rdma@lfdr.de>; Sat, 24 Oct 2020 23:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1764717AbgJXVvR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 24 Oct 2020 17:51:17 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:15571 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1764656AbgJXVvR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 24 Oct 2020 17:51:17 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f94a1c00000>; Sat, 24 Oct 2020 14:50:56 -0700
Received: from [172.27.0.17] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 24 Oct
 2020 21:50:55 +0000
Subject: Re: [PATCH v3 14/56] IB: fix kernel-doc markups
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
CC:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        =?UTF-8?Q?H=c3=a5kon_Bugge?= <haakon.bugge@oracle.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Bart Van Assche <bvanassche@acm.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Danit Goldberg <danitg@mellanox.com>,
        "Dennis Dalessandro" <dennis.dalessandro@cornelisnetworks.com>,
        Divya Indi <divya.indi@oracle.com>,
        Doug Ledford <dledford@redhat.com>,
        Gal Pressman <galpress@amazon.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Maor Gottlieb <maorg@mellanox.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Moni Shoua <monis@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Ursula Braun" <ubraun@linux.ibm.com>,
        Xi Wang <wangxi11@huawei.com>,
        Yamin Friedman <yaminf@mellanox.com>,
        <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <target-devel@vger.kernel.org>
References: <cover.1603469755.git.mchehab+huawei@kernel.org>
 <f201c81b58f7087425387672b24af5b85aa04b1a.1603469755.git.mchehab+huawei@kernel.org>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <eec938e4-0a00-c35a-fc0d-8d0d4af30678@nvidia.com>
Date:   Sun, 25 Oct 2020 00:50:23 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <f201c81b58f7087425387672b24af5b85aa04b1a.1603469755.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603576256; bh=Emn32IxixaWsl7kBQOXa8DNRipC33Bf2cppVn8UIwNw=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
         Content-Language:X-Originating-IP:X-ClientProxiedBy;
        b=R3Y+v9EYFjOpNN2ihsQxxC6/4QnzJmwH32cc6MG6MG95WzmNKmqKD09UySA9+L7Mm
         t4X71bz3h4v5lPjAO1e6sXuvg4NS889Ywpxopn4iR6iMefBpZ+H1FqummbNu9huIbS
         Al9O464S7B4z1vzTGAElQz9Y7Lvmx086LaPq0PaMShJ9n5bxpux7ugexAlzSu9n1WY
         vfkB3XQOYSFA9cZEZ/kJO222AImSgtFYyjEdKuj2UwThn/jmM0UtRWfayziURo3Vfd
         Aldk+eJbOVGnjpDD9sQduNy39yOYy/SB0KrIGkurEfQqkWAevGQ0fGg7HgWthPjugs
         Hqyp9H112QRhg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Thanks Mauro, small fix for iser

On 10/23/2020 7:33 PM, Mauro Carvalho Chehab wrote:
> Some functions have different names between their prototypes
> and the kernel-doc markup.
>
> Others need to be fixed, as kernel-doc markups should use this format:
>          identifier - description
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>
> diff --git a/drivers/infiniband/ulp/iser/iscsi_iser.c b/drivers/infiniband/ulp/iser/iscsi_iser.c
> index 3690e28cc7ea..84cebf937680 100644
> --- a/drivers/infiniband/ulp/iser/iscsi_iser.c
> +++ b/drivers/infiniband/ulp/iser/iscsi_iser.c
> @@ -739,7 +739,7 @@ iscsi_iser_set_param(struct iscsi_cls_conn *cls_conn,
>   }
>   
>   /**
> - * iscsi_iser_set_param() - set class connection parameter
> + * iscsi_iser_conn_get_stats() - set class connection parameter

iscsi_iser_conn_get_stats() - get iscsi connection statistics


>    * @cls_conn:    iscsi class connection
>    * @stats:       iscsi stats to output
>    *
>   
