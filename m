Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A54945F6991
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Oct 2022 16:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbiJFO0q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Oct 2022 10:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiJFO0p (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 Oct 2022 10:26:45 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B681A72FF0
        for <linux-rdma@vger.kernel.org>; Thu,  6 Oct 2022 07:26:43 -0700 (PDT)
Message-ID: <99a4b7ea-64df-7de4-2d7a-52e797644e71@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1665066401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YaomjmDvu8JV1QBCZhL0HEbOB0ZDakxY2+Gi82giNYk=;
        b=gAAUQNVxT8Z658/X3NbeZOKpaPcbDBNscdvJ2WX2fU0Ze8rNsfmxcf+RnHpNOPiVq7FeM1
        6rc/yJyhhpmqDlSj397SMNKmNvjzYlokW7XDN8ELWkiCMnJ0m9rDMDqkWhOEPliQnBkFyt
        6zuua4g+FAOttXuutZAhl6R0kDzeh0g=
Date:   Thu, 6 Oct 2022 22:26:33 +0800
MIME-Version: 1.0
Subject: Re: [PATCH] rdma: not display the rdma link in other net namespace
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Leon Romanovsky <leo@kernel.org>, linux-rdma@vger.kernel.org,
        jgg@nvidia.com
References: <20220926024033.284341-1-yanjun.zhu@linux.dev>
 <YzLRvzAH9MqqtSGk@unreal> <4e5d49fe-38a3-4891-3755-3decf8ffebda@linux.dev>
 <YzPkAGs60Kk4QCck@unreal> <fb230416-d336-cca2-24c3-5b804c50a10e@linux.dev>
 <Yz7PsMhkWMH0HXjt@unreal>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <Yz7PsMhkWMH0HXjt@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


在 2022/10/6 20:53, Leon Romanovsky 写道:
> On Fri, Sep 30, 2022 at 03:25:00PM +0800, Yanjun Zhu wrote:
>> 在 2022/9/28 14:04, Leon Romanovsky 写道:
>>> On Tue, Sep 27, 2022 at 06:58:50PM +0800, Yanjun Zhu wrote:
>>>> 在 2022/9/27 18:34, Leon Romanovsky 写道:
>>>>> On Sun, Sep 25, 2022 at 10:40:33PM -0400, yanjun.zhu@linux.dev wrote:
>>>>>> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> <...>
>
>> Is it better to append "exclusive" or "shared" in the end of the line?
> No, exclusive/shared is global property, applied to all links.

OK.

When running "rdma link show", there is no difference between shared and 
exclusive.

Is it acceptable?


And in exclusive mode, a rdma link that can not be accessed in net 
namespace A still

appears in net namespace A when running "rdma link show" in net namespace A.

The above is different from others in net namespace.

For example, in net namespace, if net device NIC0 is moved to net 
namespace B from net namespace A,

this NIC0 will not appear in net namespace A when running "ip link" 
command in net namespace A.

Is it a problem?


Zhu Yanjun

>
> Thanks
