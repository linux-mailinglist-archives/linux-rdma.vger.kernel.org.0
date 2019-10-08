Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D12FCFF77
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Oct 2019 19:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbfJHRA6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 8 Oct 2019 13:00:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:38286 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725966AbfJHRA6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 8 Oct 2019 13:00:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6F213B1FF;
        Tue,  8 Oct 2019 17:00:56 +0000 (UTC)
Date:   Tue, 8 Oct 2019 09:59:42 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     "Koenig, Christian" <Christian.Koenig@amd.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "walken@google.com" <walken@google.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Doug Ledford <dledford@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        J?r?me Glisse <jglisse@redhat.com>,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 09/11] lib/interval-tree: convert interval_tree to half
 closed intervals
Message-ID: <20191008165942.vxfwbectycuersdx@linux-p48b>
Mail-Followup-To: "Koenig, Christian" <Christian.Koenig@amd.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "walken@google.com" <walken@google.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Doug Ledford <dledford@redhat.com>, Joerg Roedel <joro@8bytes.org>,
        J?r?me Glisse <jglisse@redhat.com>,
        Davidlohr Bueso <dbueso@suse.de>
References: <20191003201858.11666-1-dave@stgolabs.net>
 <20191003201858.11666-10-dave@stgolabs.net>
 <bc45a4c6-35ab-54a3-487f-ce41b75dd99c@amd.com>
 <d1f5de2f-006f-5e76-cd1b-1524b8bc2cb0@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <d1f5de2f-006f-5e76-cd1b-1524b8bc2cb0@amd.com>
User-Agent: NeoMutt/20180716
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, 04 Oct 2019, Koenig, Christian wrote:

>Am 04.10.19 um 08:57 schrieb Christian König:
>> Am 03.10.19 um 22:18 schrieb Davidlohr Bueso:
>>> The generic tree tree really wants [a, b) intervals, not fully closed.
>>> As such convert it to use the new interval_tree_gen.h. Most of the
>>> conversions are straightforward, with the exception of perhaps
>>> radeon_vm_bo_set_addr(), but semantics have been tried to be left
>>> untouched.
>>
>> NAK, the whole thing won't work.
>>
>> See we need to handle the full device address space which means we
>> have values in the range of 0x0-0xffffffff.
>>
>> If you make this a closed interval then the end would wrap around to
>> 0x0 if long is only 32bit.
>
>Well I've just now re-read the subject line. From that it sounds like
>you are actually trying to fix the interval tree to use a half closed
>interval, e.g. something like [a, b[

Correct.

>
>But your code changes sometimes doesn't seem to reflect that.

Hmm the change simply aims at avoiding the end - 1 trick when dealing
with interval_tree insertions and lookups; the rest of the series
converts other interval tree users in a similar way, albeit some errors
which will be updated. What are your concerns about this patch?

Thanks,
Davidlohr
