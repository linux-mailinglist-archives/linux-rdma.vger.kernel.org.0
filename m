Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E80B21AF5D7
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Apr 2020 01:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725824AbgDRXSp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 18 Apr 2020 19:18:45 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41394 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgDRXSp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 18 Apr 2020 19:18:45 -0400
Received: by mail-pg1-f196.google.com with SMTP id h69so3135174pgc.8;
        Sat, 18 Apr 2020 16:18:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9y1I3GgfaP2v1Zi5kpEKm39sN1Ea2flGE/eGUAyWwhU=;
        b=T9K9mYrjdngbdlTiwu/OubGy6FwqyRvVFINWl1LY/pIo52YntsknTCyic+SZ3Y4BH7
         YAZEpcUCjq6iOFiZd6yqtKQeXtDa1/ncwqBTuaEhVMLoQ9CieUM6egZrTmcTQ1WzfHKM
         pACDRe3ptstyJ4m3Yg04LVNEdfbHR708EjTRetjJMkgIvvKr6HK/YABErFCMCw0J7LcP
         pRlYttCezGWDhIf+lelN//Iw3TDs0/7jWHu3JXhYQtaQ0LwOZgzP6bASVsTGqVZ1v0qM
         eEcROX92KFdYkFZljpq6NZYkUIJIpi4fTUlwfCecqgnsR+y922uWjIJypCGR0HxsYC+M
         WiwQ==
X-Gm-Message-State: AGi0PuaMvuoTHuyWPfert2ADQ0uFXsvyrYp21pIe5n8TePuI2xpBDRQu
        2knNRpABovShWAK9E4SitPo=
X-Google-Smtp-Source: APiQypLNjzPi1jHmeG9cSZ/9oVmFPIX+/qco+JhNqAJh6i8cYSkF5fJ3AhuxZ8gvXnNa45sW8mnmWw==
X-Received: by 2002:aa7:874f:: with SMTP id g15mr10443949pfo.45.1587251924293;
        Sat, 18 Apr 2020 16:18:44 -0700 (PDT)
Received: from [100.124.15.238] ([104.129.198.61])
        by smtp.gmail.com with ESMTPSA id s10sm22753043pfd.124.2020.04.18.16.18.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Apr 2020 16:18:43 -0700 (PDT)
Subject: Re: [PATCH v12 18/25] block/rnbd: client: sysfs interface functions
To:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        leon@kernel.org, dledford@redhat.com, jgg@ziepe.ca,
        jinpu.wang@cloud.ionos.com, pankaj.gupta@cloud.ionos.com
References: <20200415092045.4729-1-danil.kipnis@cloud.ionos.com>
 <20200415092045.4729-19-danil.kipnis@cloud.ionos.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <2827b679-70f5-3026-605a-14f2cc89aaab@acm.org>
Date:   Sat, 18 Apr 2020 16:18:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200415092045.4729-19-danil.kipnis@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 4/15/20 2:20 AM, Danil Kipnis wrote:
> This is the sysfs interface to rnbd block devices on client side:
> 
>    /sys/class/rnbd-client/ctl/
>      |- map_device
>      |  *** maps remote device
>      |
>      |- devices/
>         *** all mapped devices
> 
>    /sys/block/rnbd<N>/rnbd/
>      |- unmap_device
>      |  *** unmaps device
>      |
>      |- state
>      |  *** device state
>      |
>      |- session
>      |  *** session name
>      |
>      |- mapping_path
>         *** path of the dev that was mapped on server

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

