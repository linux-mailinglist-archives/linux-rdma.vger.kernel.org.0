Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2F6625104
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Nov 2022 03:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbiKKCos (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Nov 2022 21:44:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233097AbiKKCoc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Nov 2022 21:44:32 -0500
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E7F8D1BD
        for <linux-rdma@vger.kernel.org>; Thu, 10 Nov 2022 18:39:31 -0800 (PST)
Message-ID: <258ab14c-1c57-f0c1-c12c-5d0471174033@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1668134337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EEWGelsrsfbH+XmCUcA0cJL/V3DhOhVfZ3FK9F8Jszg=;
        b=BwCXBbCpLfFZlRpBNhHS9AZcQCaj/KJlbSOOCYSqWZsjRm9jTNNbGOrTxn06I8/bVILU3L
        /ZlB/3mbJxMx7v3NH5Q+YgH/WkR9ZlU9/GsPivltVvL4J64SXIoUIlGxIOTelCDeNoeqtH
        e7jYdXNCE25u9CdHOahaP+29LRVw46g=
Date:   Fri, 11 Nov 2022 10:38:51 +0800
MIME-Version: 1.0
Subject: Re: RE: [PATCH 0/3] RDMA net namespace
To:     Parav Pandit <parav@nvidia.com>, Yanjun Zhu <yanjun.zhu@linux.dev>,
        "dust.li@linux.alibaba.com" <dust.li@linux.alibaba.com>,
        Zhu Yanjun <yanjun.zhu@intel.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <PH0PR12MB5481AA6E4D5BBAC76E027458DC339@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB54819EFE62D489FD489A307DDC339@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB5481D39B0CD65746C9808046DC339@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB5481F98B1941FA63985D13E0DC339@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20221023220450.2287909-1-yanjun.zhu@intel.com>
 <20221026150113.GG56517@linux.alibaba.com>
 <20221027023055.GH56517@linux.alibaba.com>
 <5314ed2c09c1336f5c21cf7c944937e4@linux.dev>
 <e2e3bc30862d0f6b2fc8296624527e0c@linux.dev>
 <6d841d006c9a79d9ecb1b1bae8d10a28@linux.dev>
 <7f5ed21ac410646aba93aac875a0d8a8@linux.dev>
 <PH0PR12MB54811A129A037D716BFD934CDC339@PH0PR12MB5481.namprd12.prod.outlook.com>
 <ddd5fb94-127a-0fc2-cadf-7a0f24fa0d15@linux.dev>
 <PH0PR12MB548174B0CD9E7DA82DF9F25CDC329@PH0PR12MB5481.namprd12.prod.outlook.com>
 <e6115b24-811e-ff61-23d3-bc3e93a4d12c@linux.dev>
 <PH0PR12MB5481389EE22F7010FCA87C3EDC329@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <PH0PR12MB5481389EE22F7010FCA87C3EDC329@PH0PR12MB5481.namprd12.prod.outlook.com>
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

在 2022/10/28 11:58, Parav Pandit 写道:
> 
>> From: Yanjun Zhu <yanjun.zhu@linux.dev>
>> Sent: Thursday, October 27, 2022 11:49 PM
> 
>>> Can you show one iproute2 example, where you specify a command on
>> device A, and kernel operates on device, A, P, Q, R?
>>
>> When you add a net devices to a bonding device, you will find changes on the
>> bonding device and the net devices.
>>
>> Or some other commands like this.
> That doesn’t count as I explained that it is more parent-child or similar control relationship, unlike rdma and netdevice as loosely coupled devices.

OK. Follow your advice.

Zhu Yanjun

> 
> Also when you move a underlaying netdev interface of bond device, bond device doesn’t automatically move to new net ns.

