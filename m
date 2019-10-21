Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A410ADF89E
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Oct 2019 01:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbfJUXZq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Oct 2019 19:25:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:49348 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728056AbfJUXZq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 21 Oct 2019 19:25:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9B8D5B210;
        Mon, 21 Oct 2019 23:25:44 +0000 (UTC)
Date:   Mon, 21 Oct 2019 16:24:23 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     akpm@linux-foundation.org, walken@google.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 11/11] x86/mm, pat: convert pat tree to generic interval
 tree
Message-ID: <20191021232423.s24x5go2ozjbvtvy@linux-p48b>
Mail-Followup-To: Ingo Molnar <mingo@kernel.org>, akpm@linux-foundation.org,
        walken@google.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Davidlohr Bueso <dbueso@suse.de>
References: <20191003201858.11666-1-dave@stgolabs.net>
 <20191003201858.11666-12-dave@stgolabs.net>
 <20191007153339.GA95072@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191007153339.GA95072@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, 07 Oct 2019, Ingo Molnar wrote:
>I suppose this will be carried in -mm?

I've just sent out a new patchset for -tip that only modified the pat
tree. It seems that this series will at least take some more time due to
the mmu_notifier rework being done - and there was some worries about
the corner case details. I think it makes sense to just port the pat
tree to the current interval tree machineary and just be done with all this.
Any future versions of this series would require a trivial two liner for pat.

Thanks,
Davidlohr
