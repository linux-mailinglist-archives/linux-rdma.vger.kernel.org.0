Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3B1CBA73
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2019 14:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730817AbfJDMas (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Oct 2019 08:30:48 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36313 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728927AbfJDMas (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Oct 2019 08:30:48 -0400
Received: by mail-pf1-f195.google.com with SMTP id y22so3839480pfr.3
        for <linux-rdma@vger.kernel.org>; Fri, 04 Oct 2019 05:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3h7sOSA5jjR1emcH5dOd6H8xcJkobT200k6X8W+3UrY=;
        b=RizUr5Ifv1Bz8eqstV0Ksj9u7iT3BnODSB9UF+fHMQWB6OJQT7drjZhpvl+9z5fgF2
         saLhn7S19fMY3bByCWvEiDR1zYH0oLs8BXfRNmgdfvGXfz6AIkny2X4q15DuAdRI/ljH
         d8suc9q/fgiLkaQjRaqqA17Ywqz0XgkG6x9XOFMqr4/Zm4mi1j1dXX/39RO+SNJ+CWhd
         rAo0bZ5e1ID09f6zmDJ+YvdcLhiSwz/NPyopNmDZAAdhG5nEweJj5/zSexE7mND/m8Wb
         McPyrdp106HPZnZX4jD8PI5wsew95R4kZjqXT7w1Ty9EEr52H6Zado1HrHQjXf7bDkAC
         rU3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3h7sOSA5jjR1emcH5dOd6H8xcJkobT200k6X8W+3UrY=;
        b=l4aa7qOcK4vJDA1bsdOUKDgjskwPTq03/LW+PAAjak+q2xLfQ8XMRltQrkQ1hrB758
         tBtCggKQahBFG6M8PhPGXr1noZ7y3hVl2tMwazEQLbRcd4pRYaYivWEB4jT6rJ2S4UB5
         z+0FwWW8CBPWpsymzgv9/1SS4YS0aZHJA01q4yBOy6hTtSfEJByEh6X8xqCMYcnOYa0r
         +/uw+n+33vvNO79g90MlV8ccQpL/cN/ulnjtNknumNbFDf3ogLGQzyzaWxRcoHg3vbqs
         M6f1e20oqhieXhYrPVsVF7DItUy4T0RncsiRuNhoCv5FoS9Zr08cDzEURs/Q1OQTbmUh
         KVQg==
X-Gm-Message-State: APjAAAWHQAB6gmVY3pnaQdZLS7OtIhgm4sTNecI99UzPdGQ+ge/wXGCU
        dUDlaIyX8xIAmYltJzIvpl32VQ==
X-Google-Smtp-Source: APXvYqwvpIBZbvlF/CMNVlUL2gBE3HIrXIodkeeSqCAg05vZLgI6flJWYprqy5/q7UrKNdq6z1Qbyw==
X-Received: by 2002:a62:5485:: with SMTP id i127mr16750418pfb.260.1570192247465;
        Fri, 04 Oct 2019 05:30:47 -0700 (PDT)
Received: from google.com ([2620:15c:2cd:202:668d:6035:b425:3a3a])
        by smtp.gmail.com with ESMTPSA id p1sm8907022pfb.112.2019.10.04.05.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 05:30:46 -0700 (PDT)
Date:   Fri, 4 Oct 2019 05:30:44 -0700
From:   Michel Lespinasse <walken@google.com>
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 08/11] mm: convert vma_interval_tree to half closed
 intervals
Message-ID: <20191004123044.GA11046@google.com>
References: <20191003201858.11666-1-dave@stgolabs.net>
 <20191003201858.11666-9-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003201858.11666-9-dave@stgolabs.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 03, 2019 at 01:18:55PM -0700, Davidlohr Bueso wrote:
> The vma and anon vma interval tree really wants [a, b) intervals,
> not fully closed. As such convert it to use the new
> interval_tree_gen.h. Because of vma_last_pgoff(), the conversion
> is quite straightforward.

I am not certain if we need to worry about integer overflow here.
The problem case would be accessing the last block of a file that is
exactly 16TB long, on an arch where long (and thus pgoff_t) is 32-bit.
Maybe FS folks can tell us whether that case is currently supported,
or if we can just not worry about it ?

I would also want to rename the fields in struct zap_details into
start_index and end_index so we can verify we don't leave any
off-by-one uses.

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
