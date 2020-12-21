Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 498A62DF774
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Dec 2020 02:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgLUB1a (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 20 Dec 2020 20:27:30 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:3054 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726146AbgLUB13 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 20 Dec 2020 20:27:29 -0500
X-IronPort-AV: E=Sophos;i="5.78,436,1599494400"; 
   d="scan'208";a="102761686"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 21 Dec 2020 09:26:43 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id A9F2E4CE4BCB;
        Mon, 21 Dec 2020 09:26:37 +0800 (CST)
Received: from [10.167.220.69] (10.167.220.69) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Mon, 21 Dec 2020 09:26:36 +0800
Message-ID: <5FDFF9CA.1060109@cn.fujitsu.com>
Date:   Mon, 21 Dec 2020 09:26:34 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.2; zh-CN; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
MIME-Version: 1.0
To:     Leon Romanovsky <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v2] librdmacm: Make some functions report proper errno
References: <20201216092252.155110-1-yangx.jy@cn.fujitsu.com> <5FD9D8B2.1020208@cn.fujitsu.com> <20201216095549.GC1060282@unreal>
In-Reply-To: <20201216095549.GC1060282@unreal>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.69]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206)
X-yoursite-MailScanner-ID: A9F2E4CE4BCB.AED70
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020/12/16 17:55, Leon Romanovsky wrote:
> On Wed, Dec 16, 2020 at 05:51:46PM +0800, Xiao Yang wrote:
>> Hi Leon,
>>
>> Thanks for your quick reply. :-)
>> I have done the same change on three
>> functions(ucma_get_device,ucma_create_cqs, rdma_create_qp_ex).
>>
>> On 2020/12/16 17:22, Xiao Yang wrote:
>>> Some functions reports fixed ENOMEM when getting any failure, so
>>> it's hard for user to know which actual error happens on them.
>>>
>>> Fixes(ucma_get_device):
>>> 2ffda7f29913 ("librdmacm: Only allocate verbs resources when needed")
>>> 191c9346f335 ("librdmacm: Reference count access to verbs context")
>>> Fixes(ucma_create_cqs):
>>> f8f1335ad8d8 ("librdmacm: make CQs optional for rdma_create_qp")
>>> 9e33488e8e50 ("librdmacm: fix all calls to set errno")
>>> Fixes(rdma_create_qp_ex):
>>> d2efdede11f7 ("r4019: Add support for userspace RDMA connection management abstraction (CMA)")
>>> 4e33a4109a62 ("librdmacm: returns errors from the library consistently")
>>> 995eb0c90c1a ("rdmacm: Add support for XRC QPs")
>> For every function, I am not sure which one is an exact commit so just
>> attach all related commits ids.
> No problem, I'll try to sort it out now.
Hi Leon,

Sorry to bother you.
Is there anything blocking the patch? :-)

Best Regards,
Xiao Yang
> Thanks
>
>
> .
>



