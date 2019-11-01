Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92EC5EC8AB
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Nov 2019 19:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbfKASxV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 1 Nov 2019 14:53:21 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:41298 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbfKASxV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 1 Nov 2019 14:53:21 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA1InEpr152995;
        Fri, 1 Nov 2019 18:52:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=WbdIr6uQ+VKrss9bMwmXr7ubweaCRh3wB5tK3WfLLi4=;
 b=k9JHO9yeOJzG+d7ALungYLcLK4/5wv4Ib72cdP0vWXPA7n7pKCM04hi97sMD18E/pTJa
 LwNY1BTYNbI42csECE+SGfYQ+dNmLTbv9xxPA7VpdvuOYUOGrjBmJ0DAuI8Wm6YEiO9F
 eoz4NwU/13pmHrzOpjMUKUHGeG1gTL5UPqkIYGbX/Hyg/TgLpABx48ffttnl2RNkqfj6
 GOn+R3QodocGZZZ0XZD+zr0i7klfcoFiZhCBR7vKetMJ0RJY9qBkuun/lxalRdM49qt8
 veUjsB2ANBFyLFdIXngijO7iiuJ2H8w/deN4BIbGIXi41sjSWQS6Hg1jZRwQe2MBkwBC AQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2vxwhg3fxf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Nov 2019 18:52:39 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA1Iminu114420;
        Fri, 1 Nov 2019 18:52:39 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2w0qdwtd52-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Nov 2019 18:52:39 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xA1Iqanl023242;
        Fri, 1 Nov 2019 18:52:37 GMT
Received: from bostrovs-us.us.oracle.com (/10.152.32.65)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 01 Nov 2019 11:52:36 -0700
Subject: Re: [PATCH v2 09/15] xen/gntdev: use mmu_range_notifier_insert
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "Felix.Kuehling@amd.com" <Felix.Kuehling@amd.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Juergen Gross <jgross@suse.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Petr Cvek <petrcvekcz@gmail.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        Christoph Hellwig <hch@infradead.org>
References: <20191028201032.6352-1-jgg@ziepe.ca>
 <20191028201032.6352-10-jgg@ziepe.ca>
 <0355257f-6a3a-cdcd-d206-aec3df97dded@oracle.com>
 <20191101174824.GP22766@mellanox.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
Openpgp: preference=signencrypt
Autocrypt: addr=boris.ostrovsky@oracle.com; prefer-encrypt=mutual; keydata=
 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
 Jg6OxFYd01z+a+oL
Message-ID: <14f96c2e-ee04-5b1a-fc32-2db1487df399@oracle.com>
Date:   Fri, 1 Nov 2019 14:51:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20191101174824.GP22766@mellanox.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9428 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1911010171
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9428 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1911010171
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 11/1/19 1:48 PM, Jason Gunthorpe wrote:
> On Wed, Oct 30, 2019 at 12:55:37PM -0400, Boris Ostrovsky wrote:
>> On 10/28/19 4:10 PM, Jason Gunthorpe wrote:
>>> From: Jason Gunthorpe <jgg@mellanox.com>
>>>
>>> gntdev simply wants to monitor a specific VMA for any notifier events,
>>> this can be done straightforwardly using mmu_range_notifier_insert() over
>>> the VMA's VA range.
>>>
>>> The notifier should be attached until the original VMA is destroyed.
>>>
>>> It is unclear if any of this is even sane, but at least a lot of duplicate
>>> code is removed.
>> I didn't have a chance to look at the patch itself yet but as a heads-up
>> --- it crashes dom0.
> Thanks Boris. I spent a bit of time and got a VM running with a xen
> 4.9 hypervisor and a kernel with this patch series. It a ubuntu bionic
> VM with the distro's xen stuff.
>
> Can you give some guidance how you made it crash? 

It crashes trying to dereference mrn->ops->invalidate in
mn_itree_invalidate() when a guest exits.

I don't think you've initialized notifier ops. I don't see you using
gntdev_mmu_ops anywhere.

-boris


> I see the VM
> autoloaded gntdev:
>
> Module                  Size  Used by
> xen_gntdev             24576  2
> xen_evtchn             16384  1
> xenfs                  16384  1
> xen_privcmd            24576  16 xenfs
>
> And lsof says several xen processes have the chardev open:
>
> xenstored  819                 root   13u      CHR              10,53      0t0      19595 /dev/xen/gntdev
> xenconsol  857                 root    8u      CHR              10,53      0t0      19595 /dev/xen/gntdev
> xenconsol  857 860             root    8u      CHR              10,53      0t0      19595 /dev/xen/gntdev
>
> But no crashing..
>
> However, I wasn't able to get my usual debug kernel .config to boot
> with the xen hypervisor, it crashes on early boot with:
>
> (XEN) Dom0 has maximum 8 VCPUs
> (XEN) Scrubbing Free RAM on 1 nodes using 8 CPUs
> (XEN) .done.
> (XEN) Initial low memory virq threshold set at 0x1000 pages.
> (XEN) Std. Loglevel: All
> (XEN) Guest Loglevel: All
> (XEN) *** Serial input -> DOM0 (type 'CTRL-a' three times to switch input to Xen)
> (XEN) Freed 468kB init memory
> (XEN) d0v0 Unhandled page fault fault/trap [#14, ec=0002]
> (XEN) Pagetable walk from fffffbfff0480fbe:
> (XEN)  L4[0x1f7] = 0000000000000000 ffffffffffffffff
> (XEN) domain_crash_sync called from entry.S: fault at ffff82d080348a06 entry.o#create_bounce_frame+0x135/0x15f
> (XEN) Domain 0 (vcpu#0) crashed on cpu#0:
> (XEN) ----[ Xen-4.9.2  x86_64  debug=n   Not tainted ]----
> (XEN) CPU:    0
> (XEN) RIP:    e033:[<ffffffff82b9f731>]
> (XEN) RFLAGS: 0000000000000296   EM: 1   CONTEXT: pv guest (d0v0)
> (XEN) rax: fffffbfff0480fbe   rbx: 0000000000000000   rcx: 00000000c0000101
> (XEN) rdx: 00000000ffffffff   rsi: ffffffff84026000   rdi: ffffffff82cb4a20
> (XEN) rbp: ffffffff82407ff8   rsp: ffffffff82407da0   r8:  0000000000000000
> (XEN) r9:  0000000000000000   r10: 0000000000000000   r11: 0000000000000000
> (XEN) r12: 0000000000000000   r13: 1ffffffff0480fbe   r14: 0000000000000000
> (XEN) r15: 0000000000000000   cr0: 000000008005003b   cr4: 00000000003506e0
> (XEN) cr3: 0000000034027000   cr2: fffffbfff0480fbe
> (XEN) fsb: 0000000000000000   gsb: ffffffff82b61000   gss: 0000000000000000
> (XEN) ds: 0000   es: 0000   fs: 0000   gs: 0000   ss: e02b   cs: e033
>
> Which is surely some .config issue, but I didn't figure out what.
>
> Jason

