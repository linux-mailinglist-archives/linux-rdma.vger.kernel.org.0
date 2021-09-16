Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92A7A40EA90
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Sep 2021 21:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233367AbhIPTEv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Sep 2021 15:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346331AbhIPTES (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Sep 2021 15:04:18 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6349FC0C6CA4
        for <linux-rdma@vger.kernel.org>; Thu, 16 Sep 2021 11:36:59 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id m26so6783875pff.3
        for <linux-rdma@vger.kernel.org>; Thu, 16 Sep 2021 11:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eF3yoGSWauBjlP/PEtThaGKhCaV9nfWn2WtwyHMH5NA=;
        b=fQ61flgpbxr+3ScvmslX6Y6UYzBrHyw+jxLOpGznkQ26CXbogaME6z2xm8KhJSqTnn
         77lgkkMT6qVpSVnIMa9CA4IUAN0kgb27nXujFw1dSciBp8EZicTCozWpovAxRZAevT+M
         3PJgfF7BblG4eAokXOWjQ1ObtUEq1NA0DMPduSUtk/8Z6AptRA77vHC+lN+6CI0dZ7iS
         TlrJPbz77xVRa9MxLxts1RuG0yon5hKXJbxU7TTYE0S0roeX8RCMGqTTcoRHQiEheJWR
         ZtJBPpysHanNjaKBKtSZ1ZOhPjcngD+VZRRKp1jNeA1evJj3KV7+WwMeqZhIbT+A+5CN
         d3Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eF3yoGSWauBjlP/PEtThaGKhCaV9nfWn2WtwyHMH5NA=;
        b=Pl0NDXc9h7qyFg0h814GLA4fffsttfcVEmphUmB33021WSeCho6AU5/48YfCWg/M1S
         FRkWcjUURlWDLHw8LyRf5wXtsnNOLGAQT5m1ALjwzNeqtcJoJaCLBfBoeMYb6mSPKGlM
         VcXlNqeC5m352ZmNn/nzlBiqViF5I7Qqo4/SLOG5J0qG224WJIdtkiwI9r6skB6t1i5/
         r/PcUR+LTiQY7y3gwElYSOp6rbs3IVE7wSouCZ1FF6hRlyfmeICIAFycYAU01MwzcTVM
         6yqCemUGGR0qeV1q0tfPPn7sYzJ2TyAC9xWCH6ZD2z2aacXXxAm++4I5O6YIfWDU6zrs
         AYnQ==
X-Gm-Message-State: AOAM530Vzby0gllppBoGXgBZzOKsjVivApVaGZA/aWcUEyYEvy0rCZUZ
        +sD+WhptySY9T3Ag29nvjhESCA==
X-Google-Smtp-Source: ABdhPJwLJjgKEcXSC9TA+AobePDdZy/P1mekisB/+SUfd6z0VLYVgxBHgOvJIavtKHhdqdSbJdImwA==
X-Received: by 2002:a65:5643:: with SMTP id m3mr6176916pgs.224.1631817418780;
        Thu, 16 Sep 2021 11:36:58 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id t14sm3895421pga.62.2021.09.16.11.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 11:36:58 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mQwFk-001qrZ-OF; Thu, 16 Sep 2021 15:36:56 -0300
Date:   Thu, 16 Sep 2021 15:36:56 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Hao Sun <sunhao.th@gmail.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org, leon@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: INFO: task hung in _destroy_id
Message-ID: <20210916183656.GS3544071@ziepe.ca>
References: <CACkBjsYvt46E2WqeJwEuemUr7pST_uk3=wvEBmdtdiAPmG40vQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACkBjsYvt46E2WqeJwEuemUr7pST_uk3=wvEBmdtdiAPmG40vQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Sep 03, 2021 at 03:44:54PM +0800, Hao Sun wrote:
> Hello,
> 
> When using Healer to fuzz the latest Linux kernel, the following crash
> was triggered.
> 
> HEAD commit: 9e9fb7655ed58-Merge tag 'net-next-5.15'
> git tree: upstream
> console output:
> https://drive.google.com/file/d/19ZvzEBJnFYlQJIn-TklSjE9ZWsxoEF7X/view?usp=sharing
> kernel config: https://drive.google.com/file/d/1zgxbwaYkrM26KEmJ-5sUZX57gfXtRrwA/view?usp=sharing
> 
> Sorry, I don't have a reproducer for this crash, hope the symbolized
> report can help.
> If you fix this issue, please add the following tag to the commit:
> Reported-by: Hao Sun <sunhao.th@gmail.com>

I think this is probably fixed by this:

https://lore.kernel.org/r/20210913093344.17230-1-thomas.liu@ucloud.cn

Jason
