Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CED5FDFCA
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Nov 2019 15:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbfKOOMN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 15 Nov 2019 09:12:13 -0500
Received: from mail-qk1-f181.google.com ([209.85.222.181]:34140 "EHLO
        mail-qk1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727406AbfKOOMM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 15 Nov 2019 09:12:12 -0500
Received: by mail-qk1-f181.google.com with SMTP id 205so8191454qkk.1
        for <linux-rdma@vger.kernel.org>; Fri, 15 Nov 2019 06:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=688DTXKSr3aomaEwniZtT0+2EO/VX7hb7rNSjmyBgCY=;
        b=AlvIrFaAMla8hhZJ7j4zMLopp1ZuByAzT8GbmYTNrtafYUqSitUrYuMok/t4DFRZfM
         h0l9TJUiZBZn0E1YaME7Uchgqd0hE3wIU0nQMvC17jlnSuxsdaj94FkMJZ6Nxs+xbntg
         AKHKqXiC1cQn0z/rsVjdp/u/71edGXbRkm6ut2QOtO05e8I1aEpN0YRvPctTONDbqOYz
         YtVvz9eyleVYpKhZpz1smTMTBOT1n3gKfuydRdQbrRY+5K9RWJ0IIHJY8dgaWy2jTSnb
         1+gYtldXg0Y7RsesupzvfrPYFLZqmmny0blwL02N0dWDayMI+QFNus3rACjQUkS63WHP
         g2Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=688DTXKSr3aomaEwniZtT0+2EO/VX7hb7rNSjmyBgCY=;
        b=KshDbGAXIFhtHq+WxfrUWbmUnuGXIh4tXIdRg+GlPlXYSDkn2FQZvgZdg7AiFTvrUf
         3CHv18CtgBjJfO9db0O3iH4UW+zHwMNgr09kCNROZkyH5ucnItd3WgM+x36C58rQ4lnO
         VXPOCviEfHMQF0ikqIFwti8eTw1G+QQ1ZE6oN8lDlj3xEeBYMm1lFZoo8aWuf7Rj+KAA
         xRalyi2Guwq44ElIitJGzWqDo4tqY6huR4VCItNDXIeDbUNpeb1xX4W1JgXtUTy1kM+b
         c8wrypp6Ra7cCPuGp8YNBvbFcaNVNARfl49KYzdxBnoy3FVCmaxEUsYr3zekxM/8KSrz
         LyXw==
X-Gm-Message-State: APjAAAWziNkCxZn83H3tdJBKG/925KT4j2VgPxsfBffp0veZUMHbZdbV
        xZVytCpLwFxJUfR72WZ+rScv/g==
X-Google-Smtp-Source: APXvYqyRbYfnUDJOxQsM1zBPoIErPRkqSqztPFvddkF6oX0O6Z8Wl+JZzN+AgsPY3jFI1hqXwNxReA==
X-Received: by 2002:a37:68a:: with SMTP id 132mr12727181qkg.359.1573827131935;
        Fri, 15 Nov 2019 06:12:11 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id j7sm4107365qkd.46.2019.11.15.06.12.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Nov 2019 06:12:11 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iVcKY-0002z0-Sr; Fri, 15 Nov 2019 10:12:10 -0400
Date:   Fri, 15 Nov 2019 10:12:10 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Vinit Agnihotri <vinita@ryussi.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [question] ibv_reg_mr() returning EACCESS
Message-ID: <20191115141210.GC4055@ziepe.ca>
References: <141f4c07-b7f1-1355-7ff7-d62605ee63b5@ryussi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <141f4c07-b7f1-1355-7ff7-d62605ee63b5@ryussi.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Nov 15, 2019 at 09:27:40AM +0530, Vinit Agnihotri wrote:
> Hi,
> 
> I am trying to use setfsgid()/setfssid() calls to ensure proper access check
> for linux users.
> 
> However if user is non-root then ibv_reg_mr() returns EACCESS. While I am
> sure I am calling ibv_reg_mr()
> 
> as root user, not sure why it still returns EACCESS.
> 
> While going through libibverbs sources I realize EACCESS might be returned
> by this call:
> 
> if (write(pd->context->cmd_fd, cmd, cmd_size) != cmd_size)
>         return errno;
> 
> Can anyone provide any insight into this behavior? Does calling these
> systems calls in threads can affect
> 
> entire process? I checked /dev/infiniband/* has appropriate privileges.

This is a security limitation, if you want do this flow you need a new
enough kernel and rdma-core to support the ioctl() scheme for calling
verbs

Jason
