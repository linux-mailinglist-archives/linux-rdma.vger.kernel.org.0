Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48774B2900
	for <lists+linux-rdma@lfdr.de>; Sat, 14 Sep 2019 01:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387786AbfIMX61 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Sep 2019 19:58:27 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40391 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387751AbfIMX61 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 Sep 2019 19:58:27 -0400
Received: by mail-pg1-f196.google.com with SMTP id w10so16086874pgj.7;
        Fri, 13 Sep 2019 16:58:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ShEFHhIomtY1EdBj3xDHbsTMPcZ4eq1/VTZy25aoBFI=;
        b=dgfsHBG+nZ4/f2xXftO/89kOK8ZYvJDtdYKoMte/gcnhsgt2CcZTgcWW4ag9WCZ0+e
         1TxLbwitvJLFh6bQP2DhWN83S7euI1Il64D3+I7N1FisLqYWWTQTITHxIJ59/WJEZuGs
         B3IErpXkvA/4X3vpoAB232tFCYHkoknIn+qwXt+/P0VKy+bPlL36TGKX/lGEQJSRJBqw
         LCoTWYTDYO2gEIsfEqu+owGZAy5Hqt5Tyu+VsU9uwbTa/9R8klil3r2hsRvn3KdvgiAm
         OqWeHimhpXcwFM4WBGi7E8XdN+X5EvoBymPDOUDkgaHLY0+G6gJr2+MxBX/yH3liZXdG
         EhYw==
X-Gm-Message-State: APjAAAVZ6x5NC4iuFMT+sXl8rIaUXP/NWiz5J5I3JEaqIjPMxQ9s9irK
        d7WZLJHEbmiL9Q1EFI35kdI=
X-Google-Smtp-Source: APXvYqzc0tfUx++62km6UONSH6MTKrbsSlMteqy0KcfVuuSZSHv0iAJ0lKHMrylAsakSRf7VaXCa/g==
X-Received: by 2002:a65:60c4:: with SMTP id r4mr117682pgv.31.1568419106550;
        Fri, 13 Sep 2019 16:58:26 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id p14sm27689684pfn.138.2019.09.13.16.58.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2019 16:58:25 -0700 (PDT)
Subject: Re: [PATCH v4 24/25] ibnbd: a bit of documentation
To:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        jgg@mellanox.com, dledford@redhat.com,
        danil.kipnis@cloud.ionos.com, rpenyaev@suse.de,
        Roman Pen <roman.penyaev@profitbricks.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
References: <20190620150337.7847-1-jinpuwang@gmail.com>
 <20190620150337.7847-25-jinpuwang@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <f9e6014b-9123-8cfb-77a2-57af953a5031@acm.org>
Date:   Fri, 13 Sep 2019 16:58:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190620150337.7847-25-jinpuwang@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/20/19 8:03 AM, Jack Wang wrote:
> From: Roman Pen <roman.penyaev@profitbricks.com>
> 
> README with description of major sysfs entries.

Please have a look at Documentation/ABI/README and follow the 
instructions from that document.

Thanks,

Bart.
