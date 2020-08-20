Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49C7924BF78
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Aug 2020 15:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgHTNsw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Aug 2020 09:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728153AbgHTNsl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Aug 2020 09:48:41 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583F1C061385
        for <linux-rdma@vger.kernel.org>; Thu, 20 Aug 2020 06:48:41 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id u24so1892096oic.7
        for <linux-rdma@vger.kernel.org>; Thu, 20 Aug 2020 06:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pM35VRwJnTLYNrIZssyLvTk2gihwuAE1ccTaOU/AngE=;
        b=M2dGTvXuuerra/zQSa3S0C8lkuTnRZti1XW+ehXdAGJaflBcPrlKmiArUlJNMF/Xk8
         EKCoVkR1Gbo2S5sAobFEZW2AvKAwb96le59klTPEwC5EdnMpGHgyM71EvywkAK814gpB
         Zg2fsS0N6NQRodGlQAlEBKdJyHEqJZy/MzH+wyx4rqKTilW9WCkOG8/M7xmEbK+E/q58
         +wb1M105HkKnlqAACcrd+P3pC2XhqZNw6Zrb5JjcyERMmysgUkclIuVRCC9QQ9LLru4W
         xIgNKUDGZ29nw88HDTuhKcvm5x9N8Ja57bxRtqLrN4cxpbNyUKCVbh0Is9my8FM73lHF
         1OeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pM35VRwJnTLYNrIZssyLvTk2gihwuAE1ccTaOU/AngE=;
        b=aVMo6Hjwv1/AvFdCpOqoQ+5Q63ze0QvEJNJqktqEc2J6ZyiO+FGm0OG03PzIMq3bV8
         Fp0L0Qh2Aci9QRutnlBtQNIkSgLATWfxP1qjOOWwQr9QMkxdJV8cEi7Y06kFb8IjZaig
         5gGzuB+CG/i1vqfcvxySiuRRRbNdKADGu+yEu+m8jhC1lY1yT7gtMZkh7VCcco+Bn0/D
         7ehFeEQjP+wawzGD5mQ9pl7A+uh+6m1heG8D3O7c1/eo5nxNpjbNxiJTdlH4e3YuPFCU
         s3zMpQKzVwgxvFB+ltA6F7o5QZtH6/5R0PvxvQEHs4yIMA+oxRQTXXupVqPshj7akOx/
         ssMA==
X-Gm-Message-State: AOAM5315V4VCslt1WbuvEEoIYyHV8busLVRvaBDtYFw/S/CaMByNE652
        vviKkAfF/HHhLMjgpSZkxwKw85qiug6x6A==
X-Google-Smtp-Source: ABdhPJyJ6bCIVTT/aoT5TxR+s0PweUgcbEgUR4/GSmWc6oB4K4kCjcsL+sQLxAv04PjKI5JFJRIzMw==
X-Received: by 2002:aca:2818:: with SMTP id 24mr1803187oix.83.1597931318769;
        Thu, 20 Aug 2020 06:48:38 -0700 (PDT)
Received: from ?IPv6:2605:6000:8b03:f000:e3e0:f66d:ec94:35f1? ([2605:6000:8b03:f000:e3e0:f66d:ec94:35f1])
        by smtp.gmail.com with ESMTPSA id 102sm480506oth.3.2020.08.20.06.48.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2020 06:48:38 -0700 (PDT)
Subject: Re: [PATCH v2 01/16] rdma_rxe: Added SPDX headers to rxe source files
To:     Zhu Yanjun <zyjzyj2000@gmail.com>, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
References: <20200819034002.8835-1-rpearson@hpe.com>
 <20200819034002.8835-2-rpearson@hpe.com>
 <a6f28450-0686-b969-0626-9ee78f129734@gmail.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <96989d4e-084c-6083-2892-e67859378b2b@gmail.com>
Date:   Thu, 20 Aug 2020 08:48:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a6f28450-0686-b969-0626-9ee78f129734@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/20/20 8:43 AM, Zhu Yanjun wrote:
> On 8/19/2020 11:39 AM, Bob Pearson wrote:
>> Added SPDX header to all tracked .c and .h files.
>>
>> Signed-off-by: Bob Pearson <rpearson@hpe.com>
>> ---
>>   drivers/infiniband/sw/rxe/rxe.c             | 31 ++-------------------
>>   drivers/infiniband/sw/rxe/rxe.h             | 31 ++-------------------
>>   drivers/infiniband/sw/rxe/rxe_av.c          | 31 ++-------------------
>>   drivers/infiniband/sw/rxe/rxe_comp.c        | 31 ++-------------------
>>   drivers/infiniband/sw/rxe/rxe_cq.c          | 31 ++-------------------
>>   drivers/infiniband/sw/rxe/rxe_hdr.h         | 31 ++-------------------
>>   drivers/infiniband/sw/rxe/rxe_hw_counters.c | 31 ++-------------------
>>   drivers/infiniband/sw/rxe/rxe_hw_counters.h | 31 ++-------------------
>>   drivers/infiniband/sw/rxe/rxe_icrc.c        | 31 ++-------------------
>>   drivers/infiniband/sw/rxe/rxe_loc.h         | 31 ++-------------------
>>   drivers/infiniband/sw/rxe/rxe_mcast.c       | 31 ++-------------------
>>   drivers/infiniband/sw/rxe/rxe_mmap.c        | 31 ++-------------------
>>   drivers/infiniband/sw/rxe/rxe_mr.c          | 31 ++-------------------
>>   drivers/infiniband/sw/rxe/rxe_net.c         | 31 ++-------------------
>>   drivers/infiniband/sw/rxe/rxe_net.h         | 31 ++-------------------
>>   drivers/infiniband/sw/rxe/rxe_opcode.c      | 31 ++-------------------
>>   drivers/infiniband/sw/rxe/rxe_opcode.h      | 31 ++-------------------
>>   drivers/infiniband/sw/rxe/rxe_param.h       | 31 ++-------------------
>>   drivers/infiniband/sw/rxe/rxe_pool.c        | 31 ++-------------------
>>   drivers/infiniband/sw/rxe/rxe_pool.h        | 31 ++-------------------
>>   drivers/infiniband/sw/rxe/rxe_qp.c          | 31 ++-------------------
>>   drivers/infiniband/sw/rxe/rxe_queue.c       | 31 ++-------------------
>>   drivers/infiniband/sw/rxe/rxe_queue.h       | 31 ++-------------------
>>   drivers/infiniband/sw/rxe/rxe_recv.c        | 31 ++-------------------
>>   drivers/infiniband/sw/rxe/rxe_req.c         | 31 ++-------------------
>>   drivers/infiniband/sw/rxe/rxe_resp.c        | 31 ++-------------------
>>   drivers/infiniband/sw/rxe/rxe_srq.c         | 31 ++-------------------
>>   drivers/infiniband/sw/rxe/rxe_sysfs.c       | 31 ++-------------------
>>   drivers/infiniband/sw/rxe/rxe_task.c        | 31 ++-------------------
>>   drivers/infiniband/sw/rxe/rxe_task.h        | 31 ++-------------------
>>   drivers/infiniband/sw/rxe/rxe_verbs.c       | 31 ++-------------------
>>   drivers/infiniband/sw/rxe/rxe_verbs.h       | 31 ++-------------------
>>   32 files changed, 96 insertions(+), 896 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
>> index 5642eefb4ba1..3a46df0fb4a0 100644
>> --- a/drivers/infiniband/sw/rxe/rxe.c
>> +++ b/drivers/infiniband/sw/rxe/rxe.c
>> @@ -1,34 +1,9 @@
>> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
> 
> The license is changed?
> 
> Why?
> 
>>   /*
>> + * linux/drivers/infiniband/sw/rxe/rxe.c
>> + *
>>    * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
>>    * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
>> - *
>> - * This software is available to you under a choice of one of two
>> - * licenses.  You may choose to be licensed under the terms of the GNU
>> - * General Public License (GPL) Version 2, available from the file
>> - * COPYING in the main directory of this source tree, or the
>> - * OpenIB.org BSD license below:
>> - *
>> - *     Redistribution and use in source and binary forms, with or
>> - *     without modification, are permitted provided that the following
>> - *     conditions are met:
>> - *
>> - *    - Redistributions of source code must retain the above
>> - *      copyright notice, this list of conditions and the following
>> - *      disclaimer.
>> - *
>> - *    - Redistributions in binary form must reproduce the above
>> - *      copyright notice, this list of conditions and the following
>> - *      disclaimer in the documentation and/or other materials
>> - *      provided with the distribution.
>> - *
>> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> - * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>> - * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>> - * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
>> - * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
>> - * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
>> - * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
>> - * SOFTWARE.
>>    */
>>     #include <rdma/rdma_netlink.h>
>> diff --git a/drivers/infiniband/sw/rxe/rxe.h b/drivers/infiniband/sw/rxe/rxe.h
>> index fb07eed9e402..c5a2ee265fa7 100644
>> --- a/drivers/infiniband/sw/rxe/rxe.h
>> +++ b/drivers/infiniband/sw/rxe/rxe.h
>> @@ -1,34 +1,9 @@
>> +/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
>>   /*
>> + * linux/drivers/infiniband/sw/rxe/rxe.h
>> + *
>>    * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
>>    * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
>> - *
>> - * This software is available to you under a choice of one of two
>> - * licenses.  You may choose to be licensed under the terms of the GNU
>> - * General Public License (GPL) Version 2, available from the file
>> - * COPYING in the main directory of this source tree, or the
>> - * OpenIB.org BSD license below:
>> - *
>> - *     Redistribution and use in source and binary forms, with or
>> - *     without modification, are permitted provided that the following
>> - *     conditions are met:
>> - *
>> - *    - Redistributions of source code must retain the above
>> - *      copyright notice, this list of conditions and the following
>> - *      disclaimer.
>> - *
>> - *    - Redistributions in binary form must reproduce the above
>> - *      copyright notice, this list of conditions and the following
>> - *      disclaimer in the documentation and/or other materials
>> - *      provided with the distribution.
>> - *
>> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> - * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>> - * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>> - * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
>> - * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
>> - * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
>> - * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
>> - * SOFTWARE.
>>    */
>>     #ifndef RXE_H
>> diff --git a/drivers/infiniband/sw/rxe/rxe_av.c b/drivers/infiniband/sw/rxe/rxe_av.c
>> index 81ee756c19b8..de9445d7210d 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_av.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_av.c
>> @@ -1,34 +1,9 @@
>> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
>>   /*
>> + * linux/drivers/infiniband/sw/rxe/rxe_av.c
>> + *
>>    * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
>>    * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
>> - *
>> - * This software is available to you under a choice of one of two
>> - * licenses.  You may choose to be licensed under the terms of the GNU
>> - * General Public License (GPL) Version 2, available from the file
>> - * COPYING in the main directory of this source tree, or the
>> - * OpenIB.org BSD license below:
>> - *
>> - *       Redistribution and use in source and binary forms, with or
>> - *       without modification, are permitted provided that the following
>> - *       conditions are met:
>> - *
>> - *        - Redistributions of source code must retain the above
>> - *          copyright notice, this list of conditions and the following
>> - *          disclaimer.
>> - *
>> - *        - Redistributions in binary form must reproduce the above
>> - *          copyright notice, this list of conditions and the following
>> - *          disclaimer in the documentation and/or other materials
>> - *          provided with the distribution.
>> - *
>> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> - * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>> - * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>> - * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
>> - * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
>> - * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
>> - * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
>> - * SOFTWARE.
>>    */
>>     #include "rxe.h"
>> diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
>> index 4bc88708b355..ab1e61ca98d0 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_comp.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_comp.c
>> @@ -1,34 +1,9 @@
>> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
>>   /*
>> + * linux/drivers/infiniband/sw/rxe/rxe_comp.c
>> + *
>>    * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
>>    * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
>> - *
>> - * This software is available to you under a choice of one of two
>> - * licenses.  You may choose to be licensed under the terms of the GNU
>> - * General Public License (GPL) Version 2, available from the file
>> - * COPYING in the main directory of this source tree, or the
>> - * OpenIB.org BSD license below:
>> - *
>> - *     Redistribution and use in source and binary forms, with or
>> - *     without modification, are permitted provided that the following
>> - *     conditions are met:
>> - *
>> - *    - Redistributions of source code must retain the above
>> - *      copyright notice, this list of conditions and the following
>> - *      disclaimer.
>> - *
>> - *    - Redistributions in binary form must reproduce the above
>> - *      copyright notice, this list of conditions and the following
>> - *      disclaimer in the documentation and/or other materials
>> - *      provided with the distribution.
>> - *
>> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> - * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>> - * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>> - * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
>> - * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
>> - * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
>> - * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
>> - * SOFTWARE.
>>    */
>>     #include <linux/skbuff.h>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_cq.c b/drivers/infiniband/sw/rxe/rxe_cq.c
>> index ad3090131126..4e5c325f74f4 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_cq.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_cq.c
>> @@ -1,34 +1,9 @@
>> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
>>   /*
>> + * linux/drivers/infiniband/sw/rxe/rxe_cq.c
>> + *
>>    * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
>>    * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
>> - *
>> - * This software is available to you under a choice of one of two
>> - * licenses.  You may choose to be licensed under the terms of the GNU
>> - * General Public License (GPL) Version 2, available from the file
>> - * COPYING in the main directory of this source tree, or the
>> - * OpenIB.org BSD license below:
>> - *
>> - *       Redistribution and use in source and binary forms, with or
>> - *       without modification, are permitted provided that the following
>> - *       conditions are met:
>> - *
>> - *    - Redistributions of source code must retain the above
>> - *      copyright notice, this list of conditions and the following
>> - *      disclaimer.
>> - *
>> - *    - Redistributions in binary form must reproduce the above
>> - *      copyright notice, this list of conditions and the following
>> - *      disclaimer in the documentation and/or other materials
>> - *      provided with the distribution.
>> - *
>> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> - * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>> - * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>> - * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
>> - * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
>> - * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
>> - * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
>> - * SOFTWARE.
>>    */
>>   #include <linux/vmalloc.h>
>>   #include "rxe.h"
>> diff --git a/drivers/infiniband/sw/rxe/rxe_hdr.h b/drivers/infiniband/sw/rxe/rxe_hdr.h
>> index ce003666b800..9a1913db86f0 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_hdr.h
>> +++ b/drivers/infiniband/sw/rxe/rxe_hdr.h
>> @@ -1,34 +1,9 @@
>> +/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
>>   /*
>> + * linux/drivers/infiniband/sw/rxe/rxe_hdr.h
>> + *
>>    * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
>>    * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
>> - *
>> - * This software is available to you under a choice of one of two
>> - * licenses.  You may choose to be licensed under the terms of the GNU
>> - * General Public License (GPL) Version 2, available from the file
>> - * COPYING in the main directory of this source tree, or the
>> - * OpenIB.org BSD license below:
>> - *
>> - *     Redistribution and use in source and binary forms, with or
>> - *     without modification, are permitted provided that the following
>> - *     conditions are met:
>> - *
>> - *    - Redistributions of source code must retain the above
>> - *      copyright notice, this list of conditions and the following
>> - *      disclaimer.
>> - *
>> - *    - Redistributions in binary form must reproduce the above
>> - *      copyright notice, this list of conditions and the following
>> - *      disclaimer in the documentation and/or other materials
>> - *      provided with the distribution.
>> - *
>> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> - * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>> - * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>> - * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
>> - * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
>> - * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
>> - * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
>> - * SOFTWARE.
>>    */
>>     #ifndef RXE_HDR_H
>> diff --git a/drivers/infiniband/sw/rxe/rxe_hw_counters.c b/drivers/infiniband/sw/rxe/rxe_hw_counters.c
>> index 636edb5f4cf4..1cbf4887d7b2 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_hw_counters.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_hw_counters.c
>> @@ -1,33 +1,8 @@
>> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
>>   /*
>> - * Copyright (c) 2017 Mellanox Technologies Ltd. All rights reserved.
>> - *
>> - * This software is available to you under a choice of one of two
>> - * licenses.  You may choose to be licensed under the terms of the GNU
>> - * General Public License (GPL) Version 2, available from the file
>> - * COPYING in the main directory of this source tree, or the
>> - * OpenIB.org BSD license below:
>> - *
>> - *     Redistribution and use in source and binary forms, with or
>> - *     without modification, are permitted provided that the following
>> - *     conditions are met:
>> + * linux/drivers/infiniband/sw/rxe/rxe_hw_counters.c
>>    *
>> - *    - Redistributions of source code must retain the above
>> - *      copyright notice, this list of conditions and the following
>> - *      disclaimer.
>> - *
>> - *    - Redistributions in binary form must reproduce the above
>> - *      copyright notice, this list of conditions and the following
>> - *      disclaimer in the documentation and/or other materials
>> - *      provided with the distribution.
>> - *
>> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> - * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>> - * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>> - * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
>> - * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
>> - * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
>> - * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
>> - * SOFTWARE.
>> + * Copyright (c) 2017 Mellanox Technologies Ltd. All rights reserved.
>>    */
>>     #include "rxe.h"
>> diff --git a/drivers/infiniband/sw/rxe/rxe_hw_counters.h b/drivers/infiniband/sw/rxe/rxe_hw_counters.h
>> index 72c0d63c79e0..9718ecc10130 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_hw_counters.h
>> +++ b/drivers/infiniband/sw/rxe/rxe_hw_counters.h
>> @@ -1,33 +1,8 @@
>> +/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
>>   /*
>> - * Copyright (c) 2017 Mellanox Technologies Ltd. All rights reserved.
>> - *
>> - * This software is available to you under a choice of one of two
>> - * licenses.  You may choose to be licensed under the terms of the GNU
>> - * General Public License (GPL) Version 2, available from the file
>> - * COPYING in the main directory of this source tree, or the
>> - * OpenIB.org BSD license below:
>> - *
>> - *     Redistribution and use in source and binary forms, with or
>> - *     without modification, are permitted provided that the following
>> - *     conditions are met:
>> + * linux/drivers/infiniband/sw/rxe/rxe_hw_counters.h
>>    *
>> - *    - Redistributions of source code must retain the above
>> - *      copyright notice, this list of conditions and the following
>> - *      disclaimer.
>> - *
>> - *    - Redistributions in binary form must reproduce the above
>> - *      copyright notice, this list of conditions and the following
>> - *      disclaimer in the documentation and/or other materials
>> - *      provided with the distribution.
>> - *
>> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> - * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>> - * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>> - * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
>> - * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
>> - * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
>> - * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
>> - * SOFTWARE.
>> + * Copyright (c) 2017 Mellanox Technologies Ltd. All rights reserved.
>>    */
>>     #ifndef RXE_HW_COUNTERS_H
>> diff --git a/drivers/infiniband/sw/rxe/rxe_icrc.c b/drivers/infiniband/sw/rxe/rxe_icrc.c
>> index 39e0be31aab1..398f632d8958 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_icrc.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_icrc.c
>> @@ -1,34 +1,9 @@
>> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
>>   /*
>> + * linux/drivers/infiniband/sw/rxe/rxe_icrc.c
>> + *
>>    * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
>>    * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
>> - *
>> - * This software is available to you under a choice of one of two
>> - * licenses.  You may choose to be licensed under the terms of the GNU
>> - * General Public License (GPL) Version 2, available from the file
>> - * COPYING in the main directory of this source tree, or the
>> - * OpenIB.org BSD license below:
>> - *
>> - *     Redistribution and use in source and binary forms, with or
>> - *     without modification, are permitted provided that the following
>> - *     conditions are met:
>> - *
>> - *    - Redistributions of source code must retain the above
>> - *      copyright notice, this list of conditions and the following
>> - *      disclaimer.
>> - *
>> - *    - Redistributions in binary form must reproduce the above
>> - *      copyright notice, this list of conditions and the following
>> - *      disclaimer in the documentation and/or other materials
>> - *      provided with the distribution.
>> - *
>> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> - * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>> - * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>> - * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
>> - * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
>> - * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
>> - * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
>> - * SOFTWARE.
>>    */
>>     #include "rxe.h"
>> diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
>> index 775c23becaec..73e3253c7817 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_loc.h
>> +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
>> @@ -1,34 +1,9 @@
>> +/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
>>   /*
>> + * linux/drivers/infiniband/sw/rxe/rxe_loc.h
>> + *
>>    * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
>>    * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
>> - *
>> - * This software is available to you under a choice of one of two
>> - * licenses.  You may choose to be licensed under the terms of the GNU
>> - * General Public License (GPL) Version 2, available from the file
>> - * COPYING in the main directory of this source tree, or the
>> - * OpenIB.org BSD license below:
>> - *
>> - *     Redistribution and use in source and binary forms, with or
>> - *     without modification, are permitted provided that the following
>> - *     conditions are met:
>> - *
>> - *    - Redistributions of source code must retain the above
>> - *      copyright notice, this list of conditions and the following
>> - *      disclaimer.
>> - *
>> - *    - Redistributions in binary form must reproduce the above
>> - *      copyright notice, this list of conditions and the following
>> - *      disclaimer in the documentation and/or other materials
>> - *      provided with the distribution.
>> - *
>> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> - * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>> - * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>> - * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
>> - * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
>> - * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
>> - * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
>> - * SOFTWARE.
>>    */
>>     #ifndef RXE_LOC_H
>> diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
>> index 522a7942c56c..4c7304a6259a 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_mcast.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
>> @@ -1,34 +1,9 @@
>> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
>>   /*
>> + * linux/drivers/infiniband/sw/rxe/rxe_mcast.c
>> + *
>>    * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
>>    * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
>> - *
>> - * This software is available to you under a choice of one of two
>> - * licenses.  You may choose to be licensed under the terms of the GNU
>> - * General Public License (GPL) Version 2, available from the file
>> - * COPYING in the main directory of this source tree, or the
>> - * OpenIB.org BSD license below:
>> - *
>> - *       Redistribution and use in source and binary forms, with or
>> - *       without modification, are permitted provided that the following
>> - *       conditions are met:
>> - *
>> - *        - Redistributions of source code must retain the above
>> - *          copyright notice, this list of conditions and the following
>> - *          disclaimer.
>> - *
>> - *        - Redistributions in binary form must reproduce the above
>> - *          copyright notice, this list of conditions and the following
>> - *          disclaimer in the documentation and/or other materials
>> - *          provided with the distribution.
>> - *
>> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> - * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>> - * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>> - * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
>> - * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
>> - * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
>> - * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
>> - * SOFTWARE.
>>    */
>>     #include "rxe.h"
>> diff --git a/drivers/infiniband/sw/rxe/rxe_mmap.c b/drivers/infiniband/sw/rxe/rxe_mmap.c
>> index 7887f623f62c..a6179dc65ca4 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_mmap.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_mmap.c
>> @@ -1,34 +1,9 @@
>> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
>>   /*
>> + * linux/drivers/infiniband/sw/rxe/rxe_mmap.c
>> + *
>>    * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
>>    * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
>> - *
>> - * This software is available to you under a choice of one of two
>> - * licenses.  You may choose to be licensed under the terms of the GNU
>> - * General Public License (GPL) Version 2, available from the file
>> - * COPYING in the main directory of this source tree, or the
>> - * OpenIB.org BSD license below:
>> - *
>> - *     Redistribution and use in source and binary forms, with or
>> - *     without modification, are permitted provided that the following
>> - *     conditions are met:
>> - *
>> - *    - Redistributions of source code must retain the above
>> - *      copyright notice, this list of conditions and the following
>> - *      disclaimer.
>> - *
>> - *    - Redistributions in binary form must reproduce the above
>> - *      copyright notice, this list of conditions and the following
>> - *      disclaimer in the documentation and/or other materials
>> - *      provided with the distribution.
>> - *
>> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> - * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>> - * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>> - * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
>> - * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
>> - * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
>> - * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
>> - * SOFTWARE.
>>    */
>>     #include <linux/module.h>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
>> index e83c7b518bfa..17096b1d51c1 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
>> @@ -1,34 +1,9 @@
>> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
>>   /*
>> + * linux/drivers/infiniband/sw/rxe/rxe_mr.c
>> + *
>>    * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
>>    * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
>> - *
>> - * This software is available to you under a choice of one of two
>> - * licenses.  You may choose to be licensed under the terms of the GNU
>> - * General Public License (GPL) Version 2, available from the file
>> - * COPYING in the main directory of this source tree, or the
>> - * OpenIB.org BSD license below:
>> - *
>> - *     Redistribution and use in source and binary forms, with or
>> - *     without modification, are permitted provided that the following
>> - *     conditions are met:
>> - *
>> - *    - Redistributions of source code must retain the above
>> - *      copyright notice, this list of conditions and the following
>> - *      disclaimer.
>> - *
>> - *    - Redistributions in binary form must reproduce the above
>> - *      copyright notice, this list of conditions and the following
>> - *      disclaimer in the documentation and/or other materials
>> - *      provided with the distribution.
>> - *
>> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> - * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>> - * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>> - * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
>> - * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
>> - * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
>> - * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
>> - * SOFTWARE.
>>    */
>>     #include "rxe.h"
>> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
>> index 312c2fc961c0..c4cab17188e2 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_net.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
>> @@ -1,34 +1,9 @@
>> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
>>   /*
>> + * linux/drivers/infiniband/sw/rxe/rxe_net.c
>> + *
>>    * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
>>    * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
>> - *
>> - * This software is available to you under a choice of one of two
>> - * licenses.  You may choose to be licensed under the terms of the GNU
>> - * General Public License (GPL) Version 2, available from the file
>> - * COPYING in the main directory of this source tree, or the
>> - * OpenIB.org BSD license below:
>> - *
>> - *     Redistribution and use in source and binary forms, with or
>> - *     without modification, are permitted provided that the following
>> - *     conditions are met:
>> - *
>> - *    - Redistributions of source code must retain the above
>> - *      copyright notice, this list of conditions and the following
>> - *      disclaimer.
>> - *
>> - *    - Redistributions in binary form must reproduce the above
>> - *      copyright notice, this list of conditions and the following
>> - *      disclaimer in the documentation and/or other materials
>> - *      provided with the distribution.
>> - *
>> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> - * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>> - * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>> - * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
>> - * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
>> - * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
>> - * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
>> - * SOFTWARE.
>>    */
>>     #include <linux/skbuff.h>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_net.h b/drivers/infiniband/sw/rxe/rxe_net.h
>> index 2ca71d3d245c..e899f588fc2f 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_net.h
>> +++ b/drivers/infiniband/sw/rxe/rxe_net.h
>> @@ -1,34 +1,9 @@
>> +/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
>>   /*
>> + * linux/drivers/infiniband/sw/rxe/rxe_net.h
>> + *
>>    * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
>>    * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
>> - *
>> - * This software is available to you under a choice of one of two
>> - * licenses.  You may choose to be licensed under the terms of the GNU
>> - * General Public License (GPL) Version 2, available from the file
>> - * COPYING in the main directory of this source tree, or the
>> - * OpenIB.org BSD license below:
>> - *
>> - *     Redistribution and use in source and binary forms, with or
>> - *     without modification, are permitted provided that the following
>> - *     conditions are met:
>> - *
>> - *    - Redistributions of source code must retain the above
>> - *      copyright notice, this list of conditions and the following
>> - *      disclaimer.
>> - *
>> - *    - Redistributions in binary form must reproduce the above
>> - *      copyright notice, this list of conditions and the following
>> - *      disclaimer in the documentation and/or other materials
>> - *      provided with the distribution.
>> - *
>> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> - * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>> - * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>> - * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
>> - * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
>> - * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
>> - * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
>> - * SOFTWARE.
>>    */
>>     #ifndef RXE_NET_H
>> diff --git a/drivers/infiniband/sw/rxe/rxe_opcode.c b/drivers/infiniband/sw/rxe/rxe_opcode.c
>> index 4cf11063e0b5..ddfc08c14893 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_opcode.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_opcode.c
>> @@ -1,34 +1,9 @@
>> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
>>   /*
>> + * linux/drivers/infiniband/sw/rxe/rxe_opcode.c
>> + *
>>    * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
>>    * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
>> - *
>> - * This software is available to you under a choice of one of two
>> - * licenses.  You may choose to be licensed under the terms of the GNU
>> - * General Public License (GPL) Version 2, available from the file
>> - * COPYING in the main directory of this source tree, or the
>> - * OpenIB.org BSD license below:
>> - *
>> - *     Redistribution and use in source and binary forms, with or
>> - *     without modification, are permitted provided that the following
>> - *     conditions are met:
>> - *
>> - *    - Redistributions of source code must retain the above
>> - *      copyright notice, this list of conditions and the following
>> - *      disclaimer.
>> - *
>> - *    - Redistributions in binary form must reproduce the above
>> - *      copyright notice, this list of conditions and the following
>> - *      disclaimer in the documentation and/or other materials
>> - *      provided with the distribution.
>> - *
>> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> - * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>> - * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>> - * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
>> - * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
>> - * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
>> - * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
>> - * SOFTWARE.
>>    */
>>     #include <rdma/ib_pack.h>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_opcode.h b/drivers/infiniband/sw/rxe/rxe_opcode.h
>> index 307604e9c78d..59e8b3875826 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_opcode.h
>> +++ b/drivers/infiniband/sw/rxe/rxe_opcode.h
>> @@ -1,34 +1,9 @@
>> +/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
>>   /*
>> + * linux/drivers/infiniband/sw/rxe/rxe_opcode.h
>> + *
>>    * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
>>    * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
>> - *
>> - * This software is available to you under a choice of one of two
>> - * licenses.  You may choose to be licensed under the terms of the GNU
>> - * General Public License (GPL) Version 2, available from the file
>> - * COPYING in the main directory of this source tree, or the
>> - * OpenIB.org BSD license below:
>> - *
>> - *     Redistribution and use in source and binary forms, with or
>> - *     without modification, are permitted provided that the following
>> - *     conditions are met:
>> - *
>> - *    - Redistributions of source code must retain the above
>> - *      copyright notice, this list of conditions and the following
>> - *      disclaimer.
>> - *
>> - *    - Redistributions in binary form must reproduce the above
>> - *      copyright notice, this list of conditions and the following
>> - *      disclaimer in the documentation and/or other materials
>> - *      provided with the distribution.
>> - *
>> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> - * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>> - * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>> - * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
>> - * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
>> - * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
>> - * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
>> - * SOFTWARE.
>>    */
>>     #ifndef RXE_OPCODE_H
>> diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
>> index 99e9d8ba9767..1a0d4da0ec3f 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_param.h
>> +++ b/drivers/infiniband/sw/rxe/rxe_param.h
>> @@ -1,34 +1,9 @@
>> +/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
>>   /*
>> + * linux/drivers/infiniband/sw/rxe/rxe_param.h
>> + *
>>    * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
>>    * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
>> - *
>> - * This software is available to you under a choice of one of two
>> - * licenses.  You may choose to be licensed under the terms of the GNU
>> - * General Public License (GPL) Version 2, available from the file
>> - * COPYING in the main directory of this source tree, or the
>> - * OpenIB.org BSD license below:
>> - *
>> - *     Redistribution and use in source and binary forms, with or
>> - *     without modification, are permitted provided that the following
>> - *     conditions are met:
>> - *
>> - *    - Redistributions of source code must retain the above
>> - *      copyright notice, this list of conditions and the following
>> - *      disclaimer.
>> - *
>> - *    - Redistributions in binary form must reproduce the above
>> - *      copyright notice, this list of conditions and the following
>> - *      disclaimer in the documentation and/or other materials
>> - *      provided with the distribution.
>> - *
>> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> - * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>> - * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>> - * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
>> - * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
>> - * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
>> - * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
>> - * SOFTWARE.
>>    */
>>     #ifndef RXE_PARAM_H
>> diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
>> index fbcbac52290b..31fb0be7cdf3 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_pool.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_pool.c
>> @@ -1,34 +1,9 @@
>> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
>>   /*
>> + * linux/drivers/infiniband/sw/rxe/rxe_pool.c
>> + *
>>    * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
>>    * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
>> - *
>> - * This software is available to you under a choice of one of two
>> - * licenses.  You may choose to be licensed under the terms of the GNU
>> - * General Public License (GPL) Version 2, available from the file
>> - * COPYING in the main directory of this source tree, or the
>> - * OpenIB.org BSD license below:
>> - *
>> - *       Redistribution and use in source and binary forms, with or
>> - *       without modification, are permitted provided that the following
>> - *       conditions are met:
>> - *
>> - *        - Redistributions of source code must retain the above
>> - *          copyright notice, this list of conditions and the following
>> - *          disclaimer.
>> - *
>> - *        - Redistributions in binary form must reproduce the above
>> - *          copyright notice, this list of conditions and the following
>> - *          disclaimer in the documentation and/or other materials
>> - *          provided with the distribution.
>> - *
>> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> - * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>> - * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>> - * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
>> - * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
>> - * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
>> - * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
>> - * SOFTWARE.
>>    */
>>     #include "rxe.h"
>> diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
>> index 2f2cff1cbe43..c5a7721c8fde 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_pool.h
>> +++ b/drivers/infiniband/sw/rxe/rxe_pool.h
>> @@ -1,34 +1,9 @@
>> +/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
>>   /*
>> + * linux/drivers/infiniband/sw/rxe/rxe_pool.h
>> + *
>>    * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
>>    * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
>> - *
>> - * This software is available to you under a choice of one of two
>> - * licenses.  You may choose to be licensed under the terms of the GNU
>> - * General Public License (GPL) Version 2, available from the file
>> - * COPYING in the main directory of this source tree, or the
>> - * OpenIB.org BSD license below:
>> - *
>> - *       Redistribution and use in source and binary forms, with or
>> - *       without modification, are permitted provided that the following
>> - *       conditions are met:
>> - *
>> - *        - Redistributions of source code must retain the above
>> - *          copyright notice, this list of conditions and the following
>> - *          disclaimer.
>> - *
>> - *        - Redistributions in binary form must reproduce the above
>> - *          copyright notice, this list of conditions and the following
>> - *          disclaimer in the documentation and/or other materials
>> - *          provided with the distribution.
>> - *
>> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> - * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>> - * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>> - * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
>> - * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
>> - * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
>> - * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
>> - * SOFTWARE.
>>    */
>>     #ifndef RXE_POOL_H
>> diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
>> index 6c11c3aeeca6..b6bf74b2fe06 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_qp.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
>> @@ -1,34 +1,9 @@
>> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
>>   /*
>> + * linux/drivers/infiniband/sw/rxe/rxe_qp.c
>> + *
>>    * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
>>    * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
>> - *
>> - * This software is available to you under a choice of one of two
>> - * licenses.  You may choose to be licensed under the terms of the GNU
>> - * General Public License (GPL) Version 2, available from the file
>> - * COPYING in the main directory of this source tree, or the
>> - * OpenIB.org BSD license below:
>> - *
>> - *       Redistribution and use in source and binary forms, with or
>> - *       without modification, are permitted provided that the following
>> - *       conditions are met:
>> - *
>> - *        - Redistributions of source code must retain the above
>> - *          copyright notice, this list of conditions and the following
>> - *          disclaimer.
>> - *
>> - *        - Redistributions in binary form must reproduce the above
>> - *          copyright notice, this list of conditions and the following
>> - *          disclaimer in the documentation and/or other materials
>> - *          provided with the distribution.
>> - *
>> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> - * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>> - * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>> - * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
>> - * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
>> - * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
>> - * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
>> - * SOFTWARE.
>>    */
>>     #include <linux/skbuff.h>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_queue.c b/drivers/infiniband/sw/rxe/rxe_queue.c
>> index 245040c3a35d..6aa4b5dac8fc 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_queue.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_queue.c
>> @@ -1,34 +1,9 @@
>> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
>>   /*
>> + * linux/drivers/infiniband/sw/rxe/rxe_queue.c
>> + *
>>    * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
>>    * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
>> - *
>> - * This software is available to you under a choice of one of two
>> - * licenses.  You may choose to be licensed under the terms of the GNU
>> - * General Public License (GPL) Version 2, available from the file
>> - * COPYING in the main directory of this source tree, or the
>> - * OpenIB.org BSD license below:
>> - *
>> - *     Redistribution and use in source and binary forms, with or
>> - *     without modification, are permitted provided that the following
>> - *     conditions are met:
>> - *
>> - *    - Redistributions of source code must retain the above
>> - *      copyright notice, this list of conditions and the following
>> - *      disclaimer.
>> - *
>> - *    - Redistributions in binary form must retailuce the above
>> - *      copyright notice, this list of conditions and the following
>> - *      disclaimer in the documentation and/or other materials
>> - *      provided with the distribution.
>> - *
>> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> - * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>> - * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>> - * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
>> - * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
>> - * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
>> - * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
>> - * SOFTWARE.
>>    */
>>     #include <linux/vmalloc.h>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_queue.h b/drivers/infiniband/sw/rxe/rxe_queue.h
>> index 8ef17d617022..799adfef6ba8 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_queue.h
>> +++ b/drivers/infiniband/sw/rxe/rxe_queue.h
>> @@ -1,34 +1,9 @@
>> +/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
>>   /*
>> + * linux/drivers/infiniband/sw/rxe/rxe_queue.h
>> + *
>>    * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
>>    * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
>> - *
>> - * This software is available to you under a choice of one of two
>> - * licenses.  You may choose to be licensed under the terms of the GNU
>> - * General Public License (GPL) Version 2, available from the file
>> - * COPYING in the main directory of this source tree, or the
>> - * OpenIB.org BSD license below:
>> - *
>> - *     Redistribution and use in source and binary forms, with or
>> - *     without modification, are permitted provided that the following
>> - *     conditions are met:
>> - *
>> - *    - Redistributions of source code must retain the above
>> - *      copyright notice, this list of conditions and the following
>> - *      disclaimer.
>> - *
>> - *    - Redistributions in binary form must reproduce the above
>> - *      copyright notice, this list of conditions and the following
>> - *      disclaimer in the documentation and/or other materials
>> - *      provided with the distribution.
>> - *
>> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> - * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>> - * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>> - * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
>> - * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
>> - * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
>> - * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
>> - * SOFTWARE.
>>    */
>>     #ifndef RXE_QUEUE_H
>> diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
>> index 831ad578a7b2..c0b55b010bf5 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_recv.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_recv.c
>> @@ -1,34 +1,9 @@
>> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
>>   /*
>> + * linux/drivers/infiniband/sw/rxe/rxe_recv.c
>> + *
>>    * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
>>    * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
>> - *
>> - * This software is available to you under a choice of one of two
>> - * licenses.  You may choose to be licensed under the terms of the GNU
>> - * General Public License (GPL) Version 2, available from the file
>> - * COPYING in the main directory of this source tree, or the
>> - * OpenIB.org BSD license below:
>> - *
>> - *     Redistribution and use in source and binary forms, with or
>> - *     without modification, are permitted provided that the following
>> - *     conditions are met:
>> - *
>> - *    - Redistributions of source code must retain the above
>> - *      copyright notice, this list of conditions and the following
>> - *      disclaimer.
>> - *
>> - *    - Redistributions in binary form must reproduce the above
>> - *      copyright notice, this list of conditions and the following
>> - *      disclaimer in the documentation and/or other materials
>> - *      provided with the distribution.
>> - *
>> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> - * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>> - * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>> - * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
>> - * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
>> - * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
>> - * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
>> - * SOFTWARE.
>>    */
>>     #include <linux/skbuff.h>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
>> index e5031172c019..cc071ababcb0 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_req.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_req.c
>> @@ -1,34 +1,9 @@
>> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
>>   /*
>> + * linux/drivers/infiniband/sw/rxe/rxe_req.c
>> + *
>>    * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
>>    * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
>> - *
>> - * This software is available to you under a choice of one of two
>> - * licenses.  You may choose to be licensed under the terms of the GNU
>> - * General Public License (GPL) Version 2, available from the file
>> - * COPYING in the main directory of this source tree, or the
>> - * OpenIB.org BSD license below:
>> - *
>> - *     Redistribution and use in source and binary forms, with or
>> - *     without modification, are permitted provided that the following
>> - *     conditions are met:
>> - *
>> - *    - Redistributions of source code must retain the above
>> - *      copyright notice, this list of conditions and the following
>> - *      disclaimer.
>> - *
>> - *    - Redistributions in binary form must reproduce the above
>> - *      copyright notice, this list of conditions and the following
>> - *      disclaimer in the documentation and/or other materials
>> - *      provided with the distribution.
>> - *
>> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> - * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>> - * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>> - * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
>> - * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
>> - * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
>> - * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
>> - * SOFTWARE.
>>    */
>>     #include <linux/skbuff.h>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
>> index c4a8195bf670..aefc9a27ece5 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
>> @@ -1,34 +1,9 @@
>> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
>>   /*
>> + * linux/drivers/infiniband/sw/rxe/rxe_resp.c
>> + *
>>    * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
>>    * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
>> - *
>> - * This software is available to you under a choice of one of two
>> - * licenses.  You may choose to be licensed under the terms of the GNU
>> - * General Public License (GPL) Version 2, available from the file
>> - * COPYING in the main directory of this source tree, or the
>> - * OpenIB.org BSD license below:
>> - *
>> - *     Redistribution and use in source and binary forms, with or
>> - *     without modification, are permitted provided that the following
>> - *     conditions are met:
>> - *
>> - *    - Redistributions of source code must retain the above
>> - *      copyright notice, this list of conditions and the following
>> - *      disclaimer.
>> - *
>> - *    - Redistributions in binary form must reproduce the above
>> - *      copyright notice, this list of conditions and the following
>> - *      disclaimer in the documentation and/or other materials
>> - *      provided with the distribution.
>> - *
>> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> - * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>> - * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>> - * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
>> - * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
>> - * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
>> - * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
>> - * SOFTWARE.
>>    */
>>     #include <linux/skbuff.h>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_srq.c b/drivers/infiniband/sw/rxe/rxe_srq.c
>> index d8459431534e..a0744d6a13c2 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_srq.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_srq.c
>> @@ -1,34 +1,9 @@
>> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
>>   /*
>> + * linux/drivers/infiniband/sw/rxe/rxe_srq.c
>> + *
>>    * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
>>    * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
>> - *
>> - * This software is available to you under a choice of one of two
>> - * licenses.  You may choose to be licensed under the terms of the GNU
>> - * General Public License (GPL) Version 2, available from the file
>> - * COPYING in the main directory of this source tree, or the
>> - * OpenIB.org BSD license below:
>> - *
>> - *     Redistribution and use in source and binary forms, with or
>> - *     without modification, are permitted provided that the following
>> - *     conditions are met:
>> - *
>> - *    - Redistributions of source code must retain the above
>> - *      copyright notice, this list of conditions and the following
>> - *      disclaimer.
>> - *
>> - *    - Redistributions in binary form must reproduce the above
>> - *      copyright notice, this list of conditions and the following
>> - *      disclaimer in the documentation and/or other materials
>> - *      provided with the distribution.
>> - *
>> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> - * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>> - * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>> - * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
>> - * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
>> - * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
>> - * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
>> - * SOFTWARE.
>>    */
>>     #include <linux/vmalloc.h>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_sysfs.c b/drivers/infiniband/sw/rxe/rxe_sysfs.c
>> index ccda5f5a3bc0..83ff077b81d0 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_sysfs.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_sysfs.c
>> @@ -1,34 +1,9 @@
>> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
>>   /*
>> + * linux/drivers/infiniband/sw/rxe/rxe_sysfs.c
>> + *
>>    * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
>>    * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
>> - *
>> - * This software is available to you under a choice of one of two
>> - * licenses.  You may choose to be licensed under the terms of the GNU
>> - * General Public License (GPL) Version 2, available from the file
>> - * COPYING in the main directory of this source tree, or the
>> - * OpenIB.org BSD license below:
>> - *
>> - *     Redistribution and use in source and binary forms, with or
>> - *     without modification, are permitted provided that the following
>> - *     conditions are met:
>> - *
>> - *    - Redistributions of source code must retain the above
>> - *      copyright notice, this list of conditions and the following
>> - *      disclaimer.
>> - *
>> - *    - Redistributions in binary form must reproduce the above
>> - *      copyright notice, this list of conditions and the following
>> - *      disclaimer in the documentation and/or other materials
>> - *      provided with the distribution.
>> - *
>> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> - * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>> - * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>> - * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
>> - * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
>> - * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
>> - * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
>> - * SOFTWARE.
>>    */
>>     #include "rxe.h"
>> diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
>> index 08f05ac5f5d5..c53c639e6e40 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_task.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_task.c
>> @@ -1,34 +1,9 @@
>> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
>>   /*
>> + * linux/drivers/infiniband/sw/rxe/rxe_task.c
>> + *
>>    * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
>>    * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
>> - *
>> - * This software is available to you under a choice of one of two
>> - * licenses.  You may choose to be licensed under the terms of the GNU
>> - * General Public License (GPL) Version 2, available from the file
>> - * COPYING in the main directory of this source tree, or the
>> - * OpenIB.org BSD license below:
>> - *
>> - *       Redistribution and use in source and binary forms, with or
>> - *       without modification, are permitted provided that the following
>> - *       conditions are met:
>> - *
>> - *    - Redistributions of source code must retain the above
>> - *      copyright notice, this list of conditions and the following
>> - *      disclaimer.
>> - *
>> - *    - Redistributions in binary form must reproduce the above
>> - *      copyright notice, this list of conditions and the following
>> - *      disclaimer in the documentation and/or other materials
>> - *      provided with the distribution.
>> - *
>> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> - * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>> - * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>> - * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
>> - * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
>> - * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
>> - * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
>> - * SOFTWARE.
>>    */
>>     #include <linux/kernel.h>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_task.h b/drivers/infiniband/sw/rxe/rxe_task.h
>> index 08ff42d451c6..1b5bc405cafe 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_task.h
>> +++ b/drivers/infiniband/sw/rxe/rxe_task.h
>> @@ -1,34 +1,9 @@
>> +/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
>>   /*
>> + * linux/drivers/infiniband/sw/rxe/rxe_task.h
>> + *
>>    * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
>>    * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
>> - *
>> - * This software is available to you under a choice of one of two
>> - * licenses.  You may choose to be licensed under the terms of the GNU
>> - * General Public License (GPL) Version 2, available from the file
>> - * COPYING in the main directory of this source tree, or the
>> - * OpenIB.org BSD license below:
>> - *
>> - *       Redistribution and use in source and binary forms, with or
>> - *       without modification, are permitted provided that the following
>> - *       conditions are met:
>> - *
>> - *    - Redistributions of source code must retain the above
>> - *      copyright notice, this list of conditions and the following
>> - *      disclaimer.
>> - *
>> - *    - Redistributions in binary form must reproduce the above
>> - *      copyright notice, this list of conditions and the following
>> - *      disclaimer in the documentation and/or other materials
>> - *      provided with the distribution.
>> - *
>> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> - * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>> - * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>> - * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
>> - * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
>> - * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
>> - * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
>> - * SOFTWARE.
>>    */
>>     #ifndef RXE_TASK_H
>> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
>> index b8a22af724e8..8a7b23f6e7b6 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
>> @@ -1,34 +1,9 @@
>> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
>>   /*
>> + * linux/drivers/infiniband/sw/rxe/rxe_verbs.c
>> + *
>>    * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
>>    * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
>> - *
>> - * This software is available to you under a choice of one of two
>> - * licenses.  You may choose to be licensed under the terms of the GNU
>> - * General Public License (GPL) Version 2, available from the file
>> - * COPYING in the main directory of this source tree, or the
>> - * OpenIB.org BSD license below:
>> - *
>> - *     Redistribution and use in source and binary forms, with or
>> - *     without modification, are permitted provided that the following
>> - *     conditions are met:
>> - *
>> - *    - Redistributions of source code must retain the above
>> - *      copyright notice, this list of conditions and the following
>> - *      disclaimer.
>> - *
>> - *    - Redistributions in binary form must reproduce the above
>> - *      copyright notice, this list of conditions and the following
>> - *      disclaimer in the documentation and/or other materials
>> - *      provided with the distribution.
>> - *
>> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> - * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>> - * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>> - * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
>> - * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
>> - * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
>> - * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
>> - * SOFTWARE.
>>    */
>>     #include <linux/dma-mapping.h>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
>> index 92de39c4a7c1..5ce489b1606d 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
>> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
>> @@ -1,34 +1,9 @@
>> +/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
>>   /*
>> + * linux/drivers/infiniband/sw/rxe/rxe_verbs.h
>> + *
>>    * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
>>    * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
>> - *
>> - * This software is available to you under a choice of one of two
>> - * licenses.  You may choose to be licensed under the terms of the GNU
>> - * General Public License (GPL) Version 2, available from the file
>> - * COPYING in the main directory of this source tree, or the
>> - * OpenIB.org BSD license below:
>> - *
>> - *       Redistribution and use in source and binary forms, with or
>> - *       without modification, are permitted provided that the following
>> - *       conditions are met:
>> - *
>> - *    - Redistributions of source code must retain the above
>> - *      copyright notice, this list of conditions and the following
>> - *      disclaimer.
>> - *
>> - *    - Redistributions in binary form must reproduce the above
>> - *      copyright notice, this list of conditions and the following
>> - *      disclaimer in the documentation and/or other materials
>> - *      provided with the distribution.
>> - *
>> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> - * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>> - * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>> - * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
>> - * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
>> - * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
>> - * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
>> - * SOFTWARE.
>>    */
>>     #ifndef RXE_VERBS_H
> 
> 
It's the same license. Just moved to a central repository instead of each file. checkpatch now complains if files do not use SPDX headers.
