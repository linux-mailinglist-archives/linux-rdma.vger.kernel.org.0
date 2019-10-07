Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE2A1CE7A2
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Oct 2019 17:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728634AbfJGPdo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Oct 2019 11:33:44 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32812 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728594AbfJGPdo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Oct 2019 11:33:44 -0400
Received: by mail-wr1-f67.google.com with SMTP id b9so15900607wrs.0;
        Mon, 07 Oct 2019 08:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=quR8Kb6GAk4jYImEGkDjHBYeMyfZIdQBv2DrxYLvF70=;
        b=c7lu6Yh4SW2Tvuh1xafLP92jKbiNAvuBg/Km9vd0KvZU2E11+TBSVwgc3WkiZ/6GeG
         OMD89f1fH4nrgXTqmewRdrimBHyGFLGFKhNTmCzVClKy/HbvAwz5w4mlL+IVRMQCTz10
         w1XeN9pM4v/P9F0cC5BAE38SgX/rmuGkKEvFK0M0wDbKCr9fMFJduL5aLgwtmJu/HCUD
         6DJot7eTO+zB+slgYRwaG30RBBGpQ0NcW0wtW6b4Io3NSOS7ho1aA/VKEQHq8ltDWgzX
         13XSYOlp6u4QQ1/acZA8CeqSwl21x9EWYa2o7ghUB8UqvfmxtfQrxYgm+rBDK4NY3Ew1
         iafA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=quR8Kb6GAk4jYImEGkDjHBYeMyfZIdQBv2DrxYLvF70=;
        b=HsSPnQ3C7gGorDJZN3aPQzC7h69lwPkBuW7Zj4jnilP5FSKq+4WO+pFQaIu4zCKd+P
         e2ldN4IabiOBS8X1XIo6e/+vruk4nK1F7BZ5oczPmc4TGtJTdpmK/M2FAT42BANDJhlY
         jCaZGrKDtjSMMNd/SKjhHSdwTAIQ33v54ppfoRh8lEZLDTOIOfUt49vWLEwIZuxBl2j/
         8w3SbeM46iK5qoDgMpIQsBHD/AMeUWIIyrOtYjWOyBzkmaUiup+sh3JCFxOKo8FSjn9h
         Qt0EM9fXUErTQoFUu44ar/f5aIvZEgWgKkVE0uiTZ32bIoIf/iR45Ru7phHImHFeUnC5
         /5HQ==
X-Gm-Message-State: APjAAAU7DBhnrawTQbdWIkj4q8iY20vlRlHs7raZRUd7YMpTgycHBKKp
        m3qjNnSBBkoU6HoV10rxwPE=
X-Google-Smtp-Source: APXvYqz1lvbhYIE/Ji8FSRU355cLZvKRKQCsmcdWrQVr8/9Glty+Il7foi680QdDddETmlMfQpbxHQ==
X-Received: by 2002:adf:dcd2:: with SMTP id x18mr22950157wrm.220.1570462422220;
        Mon, 07 Oct 2019 08:33:42 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id a2sm21763670wrt.45.2019.10.07.08.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 08:33:41 -0700 (PDT)
Date:   Mon, 7 Oct 2019 17:33:39 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     akpm@linux-foundation.org, walken@google.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 11/11] x86/mm, pat: convert pat tree to generic interval
 tree
Message-ID: <20191007153339.GA95072@gmail.com>
References: <20191003201858.11666-1-dave@stgolabs.net>
 <20191003201858.11666-12-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003201858.11666-12-dave@stgolabs.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


* Davidlohr Bueso <dave@stgolabs.net> wrote:

> With some considerations, the custom pat_rbtree implementation can be
> simplified to use most of the generic interval_tree machinery.
> 
> o The tree inorder traversal can slightly differ when there are key
> ('start') collisions in the tree due to one going left and another right.
> This, however, only affects the output of debugfs' pat_memtype_list file.
> 
> o Generic interval trees are now semi open [a,b), which suits well with
> what pat wants.
> 
> o Erasing logic must remain untouched as well.
> 
> In order for the types to remain u64, the 'memtype_interval' calls are
> introduced, as opposed to simply using struct interval_tree.
> 
> In addition, pat tree might potentially also benefit by the fast overlap
> detection for the insertion case when looking up the first overlapping node
> in the tree.
> 
> Finally, I've tested this on various servers, via sanity warnings, running
> side by side with the current version and so far see no differences in the
> returned pointer node when doing memtype_rb_lowest_match() lookups.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: x86@kernel.org
> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
> ---
>  arch/x86/mm/pat.c        |  22 +++----
>  arch/x86/mm/pat_rbtree.c | 151 ++++++++++-------------------------------------
>  2 files changed, 43 insertions(+), 130 deletions(-)

I suppose this will be carried in -mm?

If so and if this patch is regression free, then:

  Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,
	
	Ingo
