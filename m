Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D86916EC6B
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Feb 2020 18:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731210AbgBYRXq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Feb 2020 12:23:46 -0500
Received: from postmanrt1.riken.jp ([134.160.33.66]:33184 "EHLO
        postmanrt1.riken.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731205AbgBYRXq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Feb 2020 12:23:46 -0500
X-Greylist: delayed 337 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Feb 2020 12:23:45 EST
Received: from postman-ex2.riken.jp (postman-ex2.riken.go.jp [134.160.33.92])
        by postmanrt1.riken.jp (Postfix) with ESMTP id 4D3861E26E2
        for <linux-rdma@vger.kernel.org>; Wed, 26 Feb 2020 02:18:08 +0900 (JST)
Received: from postman-ex2.riken.jp (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id EC6E86602E8;
        Wed, 26 Feb 2020 02:18:06 +0900 (JST)
Received: from postman.riken.jp (unknown [192.168.60.183])
        by postman-ex2.riken.jp (Postfix) with ESMTP id E729D66021E;
        Wed, 26 Feb 2020 02:18:06 +0900 (JST)
Received: from postman.riken.jp (localhost.localdomain [127.0.0.1])
        by postman.riken.jp (Postfix) with SMTP id BEF494B600D;
        Wed, 26 Feb 2020 02:18:06 +0900 (JST)
Received: from [192.168.11.7] (ah078064.dynamic.ppp.asahi-net.or.jp [131.129.78.64])
        by postman.riken.jp (Postfix) with ESMTPA id 838C66A00B;
        Wed, 26 Feb 2020 02:18:06 +0900 (JST)
Subject: Re: "ibstat -l" displays CA device list in an unsorted order
To:     Leon Romanovsky <leon@kernel.org>,
        Haim Boozaglo <haimbo@mellanox.com>
Cc:     linux-rdma@vger.kernel.org
References: <2b43584f-f56a-6466-a2da-43d02fad6b64@mellanox.com>
 <20200225074815.GB5347@unreal>
 <a854a50a-cce3-3a36-9fed-1e5ce3a34669@mellanox.com>
 <20200225091815.GE5347@unreal>
From:   Jens Domke <jens.domke@riken.jp>
Message-ID: <52f4364b-30c5-5c62-36bb-78341ca8fe6e@riken.jp>
Date:   Wed, 26 Feb 2020 02:18:06 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200225091815.GE5347@unreal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-PMX-Version: 6.4.8.2820816, Antispam-Engine: 2.7.2.2107409, Antispam-Data: 2020.2.25.170918, AntiVirus-Engine: 5.70.0, AntiVirus-Data: 2020.2.25.5700002
X-PMX-Version: 6.4.8.2820816, Antispam-Engine: 2.7.2.2107409, Antispam-Data: 2019.11.12.81217, AntiVirus-Engine: 5.68.0, AntiVirus-Data: 2019.11.12.5680000
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Dear Leon,

with all due respect, but if you don't want to be part of the solution,
then please at least stop being part of the problem!

I (and highly likely many other admins out there who don't follow this
list) am in full support of Haim's request for sorted output.

Not everything can/will be pinned down in a manpage, but if you insist
then sure someone can submit a amendment to the ibstat documentation
which demands alphanumeric sorting for the NICs/ports.

Best,
Jens


On 2/25/20 6:18 PM, Leon Romanovsky wrote:
> On Tue, Feb 25, 2020 at 10:36:05AM +0200, Haim Boozaglo wrote:
>>
>>
>> On 2/25/2020 9:48 AM, Leon Romanovsky wrote:
>>> On Mon, Feb 24, 2020 at 08:06:56PM +0200, Haim Boozaglo wrote:
>>>> Hi all,
>>>>
>>>> When running "ibstat" or "ibstat -l", the output of CA device list
>>>> is displayed in an unsorted order.
>>>>
>>>> Before pull request #561, ibstat displayed the CA device list sorted in
>>>> alphabetical order.
>>>>
>>>> The problem is that users expect to have the output sorted in alphabetical
>>>> order and now they get it not as expected (in an unsorted order).
>>>
>>> Do we have anything written in official man pages about this expectation?
>>> I don't think so, there is nothing "to fix".
>>>
>>> Thanks
>>>
>>>>
>>>> Best Regards,
>>>> Haim Boozaglo.
>>
>> Ok, but for many years people got used to getting sorted output in
>> alphabetical order and now they don't get it.
> 
> Like for many other things, those people will adapt.
> 
> Thanks
> 
