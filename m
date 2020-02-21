Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5896D1680AA
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Feb 2020 15:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbgBUOrO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Feb 2020 09:47:14 -0500
Received: from p3plsmtpa09-01.prod.phx3.secureserver.net ([173.201.193.230]:47661
        "EHLO p3plsmtpa09-01.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728068AbgBUOrO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 21 Feb 2020 09:47:14 -0500
Received: from [192.168.0.78] ([24.218.182.144])
        by :SMTPAUTH: with ESMTPSA
        id 59aCjaREz1pNk59aCjghlR; Fri, 21 Feb 2020 07:47:13 -0700
X-CMAE-Analysis: v=2.3 cv=Tt+Yewfh c=1 sm=1 tr=0
 a=ugQcCzLIhEHbLaAUV45L0A==:117 a=ugQcCzLIhEHbLaAUV45L0A==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=pyZ-OPpqu5Nz-L8I6UIA:9
 a=QEXdDO2ut3YA:10
X-SECURESERVER-ACCT: tom@talpey.com
Subject: Re: [RFC v2] RoCE v2.0 Entropy - IPv6 Flow Label and UDP Source Port
To:     Mark Zhang <markz@mellanox.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Alex Rosenbaum <rosenbaumalex@gmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Eran Ben Elisha <eranbe@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Alex Rosenbaum <alexr@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
References: <CAFgAxU8XmoOheJ29s7r7J23V1x0QcagDgUDVGSyfKyaWSEzRzg@mail.gmail.com>
 <62f4df50-b50d-29e2-a0f4-eccaf81bd8d9@talpey.com>
 <20200213154110.GJ31668@ziepe.ca>
 <3be3b3ff-a901-b716-827a-6b1019fa1924@mellanox.com>
 <de3aeeb7-41ef-fadc-7865-e3e9fc005476@mellanox.com>
 <55e8c9cf-cd64-27b2-1333-ac4849f5e3ff@talpey.com>
 <e758da0d-94a3-a22f-c2aa-3d13714c4ed3@talpey.com>
 <4fc5590f-727c-2395-7de0-afb1d83f546b@mellanox.com>
 <91155305-10f0-22b5-b93b-2953c53dfc46@talpey.com>
 <cb5ab63b-57cd-46ac-0d51-8bffaf537590@mellanox.com>
 <20200219130613.GM31668@ziepe.ca>
 <a0067ba5-c15b-4194-0de2-3964393e9993@talpey.com>
 <c4fc4449-94ed-805e-76d1-6ce856a4fc05@mellanox.com>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <33f075e2-b5c0-53cd-6954-7ac57eeb008f@talpey.com>
Date:   Fri, 21 Feb 2020 09:47:12 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <c4fc4449-94ed-805e-76d1-6ce856a4fc05@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfEE6fzdZCFecNIKqV34qAZ1k5Kaoe0cvCSVEB9BUgxOTodDpDupAwcTNf/GWFQ6l34vt+orFqPlaAG4goXnmpV29dvq2yVY2KD5OIjEjIIYM/7COcaXT
 2eZq5bzm/vyKHmiHpkxZ+exOWR9zA9a8sem3ECV393bRbYnQm65ITMMUMAM9UBOVoPPqbgNBiMNfd63GH0V74qQ4kjs9p8hJas3lLwg3e31RZ3W5VWSnAKZe
 UaYDl4GGhr7iuO07Fm9/lvKJgcnMn7W9BaiBsrvFkC/8iseFUHB7mYpVsKqwxV0m7f9YfcDXgfC4lL/HJwZ3HxbgdebdszC9yY4Y4kAYpSOuAWle7KPEyxNp
 Q+hV+0RNhGi08Qg2z7WIczXOEfISivV6e71ASu9HIRNRX6gjoR/ws6DXGSrULAZBhYPDObe4
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/19/2020 8:04 PM, Mark Zhang wrote:
> On 2/20/2020 1:41 AM, Tom Talpey wrote:
>> On 2/19/2020 8:06 AM, Jason Gunthorpe wrote:
>>> On Wed, Feb 19, 2020 at 02:06:28AM +0000, Mark Zhang wrote:
>>>> The symmetry is important when calculate flow_label with DstQPn/SrcQPn
>>>> for non-RDMA CM Service ID (check the first mail), so that the server
>>>> and client will have same flow_label and udp_sport. But looks like it is
>>>> not important in this case.
>>>
>>> If the application needs a certain flow label it should not rely on
>>> auto-generation, IMHO.
>>>
>>> I expect most networks will not be reversible anyhow, even with the
>>> same flow label?
>>
>> These are network flow labels, not under application control. If they
>> are under application control, that's a security issue.
>>
> 
> As Jason said application is able to control it in ipv6. Besides
> application is also able to control it for non-RDMA CM Service ID in ipv4.

Ok, well I guess that's a separate issue, let's not rathole on
it here then.

> Hi Jason, same flow label get same UDP source port, with same UDP source
> port (along with same sIP/dIP/sPort), are networks reversible?
> 
>> But I agree, if the symmetric behavior is not needed, it should be
>> ignored and a better (more uniformly distributed) hash should be chosen.
>>
>> I definitely like the simplicity and perfect flatness of the newly
>> proposed (src * 31) + dst. But that "31" causes overflow into bit 21,
>> doesn't it? (31 * 0xffff == 0x1f0000) >
> 
> I think overflow doesn't matter? We have overflow anyway if
> multiplicative is used.

Hmm, it does seem to matter because dropping bits tilts the
distribution curve. Plugging ((src * 31) + dst) & 0xFFFFF into
my little test shows some odd behaviors. It starts out flat,
then the collisions start to rise around 49000, leveling out
at 65000 to a value roughly double the initial one (528 -> 1056).
It sits there until 525700, where it falls back to the start
value (528). I don't think this is optimal :-)

Tom.
