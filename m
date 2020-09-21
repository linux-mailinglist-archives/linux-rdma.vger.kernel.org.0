Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B031D271F42
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Sep 2020 11:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgIUJtk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Sep 2020 05:49:40 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:2953 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbgIUJtj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Sep 2020 05:49:39 -0400
X-Greylist: delayed 300 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Sep 2020 05:49:39 EDT
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f6875d90000>; Mon, 21 Sep 2020 02:43:53 -0700
Received: from [172.27.0.89] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 21 Sep
 2020 09:44:37 +0000
Subject: Re: pyverbs regression
To:     Bob Pearson <rpearsonhpe@gmail.com>, <linux-rdma@vger.kernel.org>
References: <5c484f6d-364f-834d-0b16-144be92fc234@gmail.com>
From:   Edward Srouji <edwards@nvidia.com>
Message-ID: <1fb57743-20fd-1316-8071-cc3ab056e582@nvidia.com>
Date:   Mon, 21 Sep 2020 12:44:34 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <5c484f6d-364f-834d-0b16-144be92fc234@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600681433; bh=N90A865fBczELR8c9yKy5901XSPG9MKYzTCZyja3txg=;
        h=Subject:To:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
         Content-Language:X-Originating-IP:X-ClientProxiedBy;
        b=XsZkzmcru1jO5XTTvJuR0jD8/6t2/bhKiQp1EZA195Tu2KYMby3anW4bsSMuntRKt
         zywSucNnqt4nULzh22UtLkb6/B4LgUMKtmDVjgw4HhCO/3aw0GkbCvfMBJw8nxA7Oc
         EH3wjAqk9vsi5eOhrA+/Hzcaoxv0g5ueoFQfGTzGtzXO6xOxpte7MxtYrcFeBhlYxv
         hXK6YmQVw+5J6K+GLQ8NxdM5IZbAGLe3KbPxTMVmh+n7iLIkOODXefWd+9jGE3fMqZ
         cHUvzhk1rZHZ7KRmqv77jFNfb/3TFFlx8EttbgOpK35/PTyEXFZe5svM6+MfvKt1m7
         dUk4uBMkGjpiQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Did you make sure that Pyverbs was recompiled as part of rdma-core 
rebuild? It looks like you've newer rdma-core with older Pyverbs structs.

Also, if you have multiple python versions make sure that Pyverbs was 
installed under the version you're using.

I don't see these inconsistencies, can you please provide which heads 
you're looking at in case you still seeing this?

On 9/18/2020 8:23 PM, Bob Pearson wrote:
> I pulled head of tree for rdma-core and the kernel and rebuilt them and I am now seeing the following warnings from pyverbs which I had not seen before. The tests I expected to run are still running but there seems to be an inconsistency somewhere.
>
> <frozen importlib._bootstrap>:219: RuntimeWarning: pyverbs.srq.SRQ size changed, may indicate binary incompatibility. Expected 56 from C header, got 64 from PyObject
> <frozen importlib._bootstrap>:219: RuntimeWarning: pyverbs.qp.QP size changed, may indicate binary incompatibility. Expected 104 from C header, got 112 from PyObject
> <frozen importlib._bootstrap>:219: RuntimeWarning: pyverbs.qp.QPEx size changed, may indicate binary incompatibility. Expected 112 from C header, got 120 from PyObject
>
> Bob Pearson
