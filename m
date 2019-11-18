Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFD6100B29
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Nov 2019 19:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfKRSL6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Nov 2019 13:11:58 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44170 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfKRSL6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Nov 2019 13:11:58 -0500
Received: by mail-qk1-f195.google.com with SMTP id m16so15259319qki.11
        for <linux-rdma@vger.kernel.org>; Mon, 18 Nov 2019 10:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0XnZJa3wgUG/2kQzcrj61tTs+JOOo5LSFOwNXm8QMag=;
        b=n20tZ32iZJxsqt9sN9wI8PzW/yT7uxv4DroZg1kG5PhfA4MnfEybwgtVqda0OkOQ+K
         Dolcec//7dYCbN9V8gMKin4t85EY/YQpef9V56nunZGziLZVT8e1/obLwg8iQ+P0kp2Q
         sgJrPscOCPFTVKlK2BFTGvaNAgvZR7qtE8+9zH02gg3vaQb0qEz4O6Z2TRRxqCYtEhtC
         1cUWS9wh4kZ6wuIEre0t2T4sNXEoThW70M2U978wbKh+k+TF0Ls6uzqImmvuBBWmOA1j
         WRSjP4sGk+GJhQfi5mDTOR4U26TsgMC6+8MLwKOGaAPXEEIWC48pOarXR6Vh1hlYQcuC
         4zIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0XnZJa3wgUG/2kQzcrj61tTs+JOOo5LSFOwNXm8QMag=;
        b=tM5089ZLaiSNhQ/Qz67vu6v3eXflMtgxDT0Y+3ylqguFKiygGciaPwccE3ISaS2iYn
         gOJ5nKzxBMlha4FZwVlK/2AIcuEZc0zE5/CxLS9Shot2CGOSfYY8NpLCZkHCsEoLu6N1
         ONb4REAll5YVmlKl/cc+rQATQ8dO7gRc2q7p70wtD40enGs1yXtPbnZGdTHmOrqKvHY3
         CFKnLVqWJ4EAWx68UQm7B+yOCp5ZZjPaRJW+sWQ+J1uuvZlGHUn/lr4zuwTWeKhk25rY
         atdex0CVg81JZq1tRNLJNSk/J7EQgfpYAIiuI9zjljdaO3phHny099plU7SScq8XLij0
         JLWQ==
X-Gm-Message-State: APjAAAVumzzKWEeINYX0wq8kqLYh9mUHo89yJ+qZUIWcEy84/A+fYbCP
        PTA7pxt93KGS+lio6La6PofAAQ==
X-Google-Smtp-Source: APXvYqyOcc4dUiwMeIygN5hTJVJZ8yxw5VAt+kDbNhljxb3VEfSKFyp9an8fBns0LLer+CJX8gUAdA==
X-Received: by 2002:a37:6354:: with SMTP id x81mr17534133qkb.316.1574100715544;
        Mon, 18 Nov 2019 10:11:55 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id d18sm8791395qko.112.2019.11.18.10.11.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Nov 2019 10:11:54 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iWlVC-00029a-BI; Mon, 18 Nov 2019 14:11:54 -0400
Date:   Mon, 18 Nov 2019 14:11:54 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Devesh Sharma <devesh.sharma@broadcom.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        Luke Starrett <luke.starrett@broadcom.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: Re: [PATCH for-rc] RDMA/bnxt_re: Fix chip number validation
 Broadcom's Gen P5 series
Message-ID: <20191118181154.GE2149@ziepe.ca>
References: <1573881293-3494-1-git-send-email-devesh.sharma@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573881293-3494-1-git-send-email-devesh.sharma@broadcom.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Nov 16, 2019 at 12:14:53AM -0500, Devesh Sharma wrote:
> From: Luke Starrett <luke.starrett@broadcom.com>
> 
> In the first version of Gen P5 ASIC, chip-id was always
> set to 0x1750 for all adaptor port configurations. This
> has been fixed in the new chip rev.
> 
> Making a change in chip-number validation check to honor
> other chip-ids as well.
> 
> Signed-off-by: Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> Signed-off-by: Luke Starrett <luke.starrett@broadcom.com>
> Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/qplib_res.h | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

You marked this for-rc without a fixes line

Jason
