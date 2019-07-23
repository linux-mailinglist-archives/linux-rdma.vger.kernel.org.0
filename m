Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C16E47201E
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jul 2019 21:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729128AbfGWTeq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jul 2019 15:34:46 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:42395 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbfGWTeq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 23 Jul 2019 15:34:46 -0400
Received: by mail-pg1-f181.google.com with SMTP id t132so19902802pgb.9
        for <linux-rdma@vger.kernel.org>; Tue, 23 Jul 2019 12:34:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MuXW1nIEEy091hhE/NjXLs1PAK2oks6jGoMshMDkTjI=;
        b=QqMb3fQVGgjwFzHuJGR+e/A5jjLDNSJJNG1aOa+y63tKxAwWiTLD2k83FrxSfz0E8+
         PUbGkaWuv/YZ+dxFcV21TLhlVpcJA4JIMoHqs0vDgTxDLtCBNexUfL9AB7T1ek+gMqfu
         iVgxoODtUM6gUCDH2fDoNIr+se7GaLZlYpJ3s+l5H5/4UTwxip6xL0zLW28hOGEuYimP
         bIIo1ElkFJwFa5adaI8ZInVho9nlESQMMVtFJtO0fBV21SST3IHVmOyJ0nUHl+ybr+zg
         Itgl+bEkbrCZn9OKu6bahtM6H5fch5BzORb0IneYYrsfzxPp87oy3oMsnrGVCA4x5j0T
         agdg==
X-Gm-Message-State: APjAAAW4V01DPhNasLmhe1Jbyc7iaQb0jwHKuq9xLm3ggz+AQQNTcwJ/
        GYeMSey1YN7L4/EXhrpHWhXYEF5ixmY=
X-Google-Smtp-Source: APXvYqwAJBIDvKdbm0HZGo5NFhnzuehTR1wTPI5ORUher4J/+q97hQq+B3b/pm7TrjQZMgsbaxiWrQ==
X-Received: by 2002:a65:6709:: with SMTP id u9mr49940057pgf.58.1563910485187;
        Tue, 23 Jul 2019 12:34:45 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id c26sm44235962pfr.172.2019.07.23.12.34.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 12:34:44 -0700 (PDT)
Subject: Re: [rdma-core patch v3] srp_daemon: improve the debug message for
 is_enabled_by_rules_file
To:     Honggang Li <honli@redhat.com>, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org
References: <20190715041614.27979-1-honli@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <40deba4f-e1e9-70df-f11a-5fa609f3034f@acm.org>
Date:   Tue, 23 Jul 2019 12:34:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190715041614.27979-1-honli@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/14/19 9:16 PM, Honggang Li wrote:
> If the target was disallowed by rule file, user can not distinguish that
> from the old debug message.
> 
> pr_debug("Found an SRP target with id_ext %s - check if it allowed by rules file\n", target->id_ext);
> 
> It implicitly implied by the message next to the old debug message.
> 
> pr_debug("Found an SRP target with id_ext %s - check if it is already connected\n", target->id_ext);
> 
> The improved debug message will feedback the check result of rule file, user
> no longer needs to wonder the target is allowed or not.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
