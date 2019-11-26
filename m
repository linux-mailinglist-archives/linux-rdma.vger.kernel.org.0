Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED35410A135
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Nov 2019 16:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbfKZPbF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Nov 2019 10:31:05 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33680 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbfKZPbF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 26 Nov 2019 10:31:05 -0500
Received: by mail-qt1-f196.google.com with SMTP id y39so21842356qty.0
        for <linux-rdma@vger.kernel.org>; Tue, 26 Nov 2019 07:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=E0QXTcdGclJHmY0IhySTzDmgalYL7d+JAlqWZ8C6dKQ=;
        b=aXkORBr8r4JD5dpbmSVX9M/wF4iZWRlkrFm7JKNoG+VGaG5YLC6PhTq0vAp+nevZZQ
         U/XzGnqASx6OIPBsDZ6CsaCAgRlJwazlPzNa3u4mN11kJdZJUukne7bwQYOJcIGX+I9Z
         pQLoW/JyYWsBQ5sfMgIPdfB4rU8nIvWUM1h7neUIGzhpKmZeYzCT0rN0IaVAdtC7yee5
         BbqeSto7SsjR6Tn/Y6jgX7tnRz/D5slBrCAEmgedpGQwED37RBh85FzG1Ks4t7la9kYp
         MKlZbNm8bowJspIMQ9FNF80gUaY4Je8sbcTHvGf1oFnGu1+OFJfr35RSl4NQGabTrHE4
         dd6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E0QXTcdGclJHmY0IhySTzDmgalYL7d+JAlqWZ8C6dKQ=;
        b=EuGr2UZqkjaehk9k9j0+b+On1W0fo6g6xXSAlSOgcBVTJOhyNQ9bTVd/l0ihR7tTLw
         6kIkjRqbDmtCNCFq6B8oxICuUOx6OjQXPnK9KSoff0PWFTVlknjE2KMKRKBopxjZIFHB
         4oP5bCl/UtdXy8rfP24xf4iwZpHr9H5VdJoDJMi1WUFbApKF4Qqe0K5aaP+o7sI0cq/C
         yLuoolqMvD86mAv4d6d2ezPPZIglVCT/z7HPET4p0mKD7SbP220Pj4R54mFOvAzx8qvx
         fGH9fPCORMkXB/6h+xgyGngCvAZ7ZxyyPPrh96TF1dSrqriNQy+4hZuRC3oJFDZgsgCN
         9vWQ==
X-Gm-Message-State: APjAAAWMN6e6KlhaUP1pBJZNdrDP775zJbTLqSviInPr0RVGSGhwpVYL
        JvwlYqT7tD1JjhM2yCLrMWZw5bRm1us=
X-Google-Smtp-Source: APXvYqylezzMwQsizYJjP29qt7TnGHAehA85pj4Iz93Zlv4Y5TG6RZ4q8du1tqwC9bVWc0ChD1Zgdg==
X-Received: by 2002:ac8:4158:: with SMTP id e24mr19366359qtm.97.1574782264463;
        Tue, 26 Nov 2019 07:31:04 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id u67sm5174575qkf.115.2019.11.26.07.31.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Nov 2019 07:31:03 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iZcnv-00055W-6K; Tue, 26 Nov 2019 11:31:03 -0400
Date:   Tue, 26 Nov 2019 11:31:03 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v2 00/11] rdmavt/hfi1 updates for next
Message-ID: <20191126153103.GG11270@ziepe.ca>
References: <20191126141055.58836.79452.stgit@awfm-01.aw.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191126141055.58836.79452.stgit@awfm-01.aw.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 26, 2019 at 09:12:07AM -0500, Dennis Dalessandro wrote:
> Here are some refactoring and code reorg patches for the merge window. Nothing
> too scary, no new features. This lays the ground work for stuff coming in
> future merge cycles.

This is far too late for this cycle

Jason
