Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4C87E0C2D
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Oct 2019 21:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732564AbfJVTEU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Oct 2019 15:04:20 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38195 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732649AbfJVTEU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Oct 2019 15:04:20 -0400
Received: by mail-qk1-f195.google.com with SMTP id p4so17338042qkf.5
        for <linux-rdma@vger.kernel.org>; Tue, 22 Oct 2019 12:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RnIjMRHJMSPKbNY9niWQYtD0BFK9lkZCoZ5skYCypAo=;
        b=Cyx6nT07Vi4tJSjjzdr8xysU2m5BGHzg8F/i+q4NPjayLrf8GvyZxIrLl8teotBRhu
         qvCQX6nFhAosqiorzJ13fJvKfHoiSg3qRgJXKJmcoKWFAvjhaB5yb1lmcBvqGSHJRyEs
         7ZG85Fnh7O+aJ2VydmTeDC6Etb1I0K9mjuNlgEyZxiTdFbUTmlYSH4547SQx7aZJJ6II
         JNbhQLWx7YmccOqInrc7GAfWJMdhCcZ1oTwORxBWh+KWr/s5ofyvmc6yAiseiWosREH2
         +xNmXeOBaNAvsSqul4aioVzTYxlr3BGbcv4IXQ/93r5/iDKdNBvwFticrA7SI0O3WJlo
         1cEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RnIjMRHJMSPKbNY9niWQYtD0BFK9lkZCoZ5skYCypAo=;
        b=r2F6FiMEfhb4x3tdHDeuEzbMWYiFUhZ9g30+a8kUzCZg5+9eWW/fnzvCFcAPgZK9NY
         YY1bZm53o6lda1AFgfoORqoPp4vp/yZab1GXuByoPhaWhWE0xt0SORXAIO9IUosJGzS4
         JiTO75t10R9Jp1zSTv6OmHbjTIdFKQtjFqC4BHRVtg0KZx+bwspqQ2t0NrI8y4jCCphT
         cL/lk6EeEjr0C9GN/GG55IQDdpcBdTp8qHqe/ffS0hT6Aqzi3KIr8IQpk4BRNMYbsSlL
         c/PxZ4nl2wBR/fpY/8Tmz5jvJEHI5ZopFGhMV8cNDZ5vWUUdd0DeR2b5y0KDJZ2x2I0K
         S1PQ==
X-Gm-Message-State: APjAAAXdKyDTfgAG7UMY5kBA5NIdf9Phv680SGCkKPWWkWfXCtGXEuv6
        horCrUzP67Wq8ZuNzD+FRQj6qw==
X-Google-Smtp-Source: APXvYqzSlTX6xHqUfo5bYRRigWYkT+HGShHr3AHboMVNtRnbmnZIXOHLWYpk2QjLc5PdWsg9Zi6JKQ==
X-Received: by 2002:a05:620a:140c:: with SMTP id d12mr4494690qkj.419.1571771059522;
        Tue, 22 Oct 2019 12:04:19 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id t17sm16737280qtt.57.2019.10.22.12.04.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Oct 2019 12:04:18 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iMzS6-0002er-Eu; Tue, 22 Oct 2019 16:04:18 -0300
Date:   Tue, 22 Oct 2019 16:04:18 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Maksym Planeta <mplaneta@os.inf.tu-dresden.de>
Cc:     Moni Shoua <monis@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/10] Replace tasklets with workqueues
Message-ID: <20191022190418.GC23952@ziepe.ca>
References: <20190722151426.5266-1-mplaneta@os.inf.tu-dresden.de>
 <20190722151426.5266-11-mplaneta@os.inf.tu-dresden.de>
 <20190722153205.GG7607@ziepe.ca>
 <21a4daf9-c77e-ec80-9da0-78ab512d248d@os.inf.tu-dresden.de>
 <20190725185006.GD7467@ziepe.ca>
 <385139f2-0d31-1148-95c0-a6e6768ab413@os.inf.tu-dresden.de>
 <995754de-5ec4-0a62-991e-2ea77a6bc622@os.inf.tu-dresden.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <995754de-5ec4-0a62-991e-2ea77a6bc622@os.inf.tu-dresden.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 11, 2019 at 12:41:50PM +0200, Maksym Planeta wrote:
> Hi,
> 
> this is a kind reminder regarding the patchset. I added description of races
> in the original email.

Your patch isn't on patchworks any more, you will need to send a v2
with the updated commit descriptions

Jason
