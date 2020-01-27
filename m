Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F260614AB4C
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Jan 2020 21:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgA0UuE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Jan 2020 15:50:04 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:34030 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgA0UuD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 27 Jan 2020 15:50:03 -0500
Received: by mail-qv1-f65.google.com with SMTP id o18so5186862qvf.1
        for <linux-rdma@vger.kernel.org>; Mon, 27 Jan 2020 12:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DVgeG5Hn3w7XfqukYpE0pB9cnJhq8oSyxXGyzmmSK0Q=;
        b=Eg7sgBVUujUb9EUFpFuiVAVaUTyPfaFByQdQmTCLCSRPumO9sghSsK75MqZLs5P9gj
         lhd9C9jXAndPQNceYT710L37+ZC7pq88d12Y548QJZNwQDvyOgY7w7LSH19a7SK69HAS
         RKuIZQIVjaOabdpiPFb1DH+IKHedfD1MFek5+YWlTmIB2rsKbF4/T8V2SnEXvIr+ZGHx
         36ye7AWgUhH0GW8zg9Cwe9VuoVUK3XRCUbofYif2aUVfHsjxMpAX90W5ibCWUtoEguX2
         8h8rLCT92tUgEEzuaBcJGq0zbE8hzjZMaUGdi+T9yvwuQTweMGbCcayWVXLtRTCjTzyO
         Ea2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DVgeG5Hn3w7XfqukYpE0pB9cnJhq8oSyxXGyzmmSK0Q=;
        b=D3ighyeaciTjozZGSg2ZFxgo1Qed2d7pYGk1CxkmzjXtv6JVjfATaAnA4ni5KauafN
         zRNkPvVbU88cweZP0KCpQo9UrAyAa0033aQKzsQ3uE9D8zQfBK9Eeq+LGYr8/vINySd4
         qeJbHKsNjUuARfXq6wV1sEu3BHTEys1GLoNsngn3NTOK1HqgaConaI5et8qWr1mPqDaK
         4pMreaGjooIWL7QDFcFhssoLW6+VCuj6LjyfRzADMA4w9yqwF8lRsHqsKDgwTtAVAtC9
         hlp94yZCFiATWkIwqJBYDexK0yL3hNcDTdbUl0UoxO/7Yu+497VxPcyrM4fMEavXQZyJ
         Wtxg==
X-Gm-Message-State: APjAAAWTYTZlnBchtzeP4XqtOOx5AcBWpwNzUbKMSOj7+e8+cdKdBWW9
        zOYpFLK6/6qUXeqIdHopoKuCcA==
X-Google-Smtp-Source: APXvYqw0stHNB+ba8+gDVld1sGsCN70eNm4uiHFjRd1lKB2QRcazcH+v9e4fCvbiFt5oojaSnoH6lA==
X-Received: by 2002:ad4:44ee:: with SMTP id p14mr18193075qvt.114.1580158202812;
        Mon, 27 Jan 2020 12:50:02 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id s20sm10351425qkg.131.2020.01.27.12.50.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Jan 2020 12:50:02 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iwBKb-0005sv-Ow; Mon, 27 Jan 2020 16:50:01 -0400
Date:   Mon, 27 Jan 2020 16:50:01 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Manjunath Patil <manjunath.b.patil@oracle.com>
Cc:     haakon.bugge@oracle.com, rama.nichanamatlu@oracle.com,
        yishaih@mellanox.com, linux-rdma@vger.kernel.org, leon@kernel.org
Subject: Re: [PATCH] IB/mlx4: Fix use after free in RDMA CM disconnect code
 path
Message-ID: <20200127205001.GA21215@ziepe.ca>
References: <1580156212-28267-1-git-send-email-manjunath.b.patil@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1580156212-28267-1-git-send-email-manjunath.b.patil@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 27, 2020 at 12:16:52PM -0800, Manjunath Patil wrote:
> PS:
> This fixes the recently submitted patch from Haakon[cc'd]
> The commit hash used in here has to be updated while applying
> Commit 01528b332860 ("IB/mlx4: Fix leak in id_map_find_del") introduces
> two code paths that can pontentially cause use after free.

Okay, I squished this into the original patch

Thanks,
Jason
