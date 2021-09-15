Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C76540BF11
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Sep 2021 06:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbhIOEzt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Sep 2021 00:55:49 -0400
Received: from mail-pg1-f179.google.com ([209.85.215.179]:41557 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbhIOEzs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Sep 2021 00:55:48 -0400
Received: by mail-pg1-f179.google.com with SMTP id k24so1500489pgh.8
        for <linux-rdma@vger.kernel.org>; Tue, 14 Sep 2021 21:54:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:content-language:content-transfer-encoding;
        bh=kMujyTPHEBUEWVZSdwuQSBkcVxeQpQWQ75e+LUpOENM=;
        b=OcUrf67i2syTg7ED4jIXGcs+YGDFgEUsRr82FXiTuE66mU4mCBtmRwlfgqXHBEVP8o
         F570L1z4GR6D5citqUVcJK8payheQP2tDGrKRsrf6UxL1ywC5pmeexpYbN/065fJJcZM
         9+Qy2ZI1I6qpgFoG5Nkjq3NCfWR1dV/s5iuP252dGkYlSPoCbdZ820VoA5IIY0f1dX0Z
         lpZ62uFBzNnqhQakn83RYjVEVcGqoH9BLeOBLUbEtuJ+uPsqJsDQjOBAIvY8DSfs4TH7
         5h0SIlf0pNHX4LNq6P7JGssMHnZRDkP6tFN+TCiT4YPAMnzVIQUEU6grGAuQHZ4HcDyY
         5SuA==
X-Gm-Message-State: AOAM533vsPwmpcOQkxO0uIVy6icwcba5pv7a1XIdZ3IoKl+9LVvF2pR6
        QOzOa8Dc6cvXt0QDXWiuh8JeajeyRio=
X-Google-Smtp-Source: ABdhPJzLonDbby1C2J66Fy57PQp3XDxzk1bvNqjiEPHdVfw6vKKyejiPasoQU3Q4lxLDwEX++jay8g==
X-Received: by 2002:a63:b204:: with SMTP id x4mr18196520pge.212.1631681669677;
        Tue, 14 Sep 2021 21:54:29 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:823b:e2f5:7a33:44c7? ([2601:647:4000:d7:823b:e2f5:7a33:44c7])
        by smtp.gmail.com with ESMTPSA id i10sm12225714pfk.87.2021.09.14.21.54.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 21:54:29 -0700 (PDT)
Message-ID: <ccb9ee03-4aaa-2288-3d2f-ce01f550a609@acm.org>
Date:   Tue, 14 Sep 2021 21:54:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
From:   Bart Van Assche <bvanassche@acm.org>
Subject: v5.15-rc1 issue with the soft-iWARP driver
To:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

If I run test srp/015 from the blktests suite then the following appears
in the kernel log:

==================================================================
BUG: KASAN: null-ptr-deref in __list_del_entry_valid+0x4d/0xe0
Read of size 8 at addr 0000000000000000 by task kworker/u16:3/161

CPU: 5 PID: 161 Comm: kworker/u16:3 Not tainted 5.15.0-rc1-dbg+ #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a-rebuilt.opensuse.org 04/01/2014
Workqueue: iw_cm_wq cm_work_handler [iw_cm]
Call Trace:
  show_stack+0x52/0x58
  dump_stack_lvl+0x5b/0x82
  kasan_report.cold+0x52/0x57
  __asan_load8+0x69/0x90
  __list_del_entry_valid+0x4d/0xe0
  _cma_cancel_listens+0x49/0x230 [rdma_cm]
  _destroy_id+0x4e/0x420 [rdma_cm]
  destroy_id_handler_unlock+0xc4/0x200 [rdma_cm]
  iw_conn_req_handler+0x335/0x370 [rdma_cm]
  cm_conn_req_handler+0x546/0x7d0 [iw_cm]
  cm_work_handler+0x419/0x480 [iw_cm]
  process_one_work+0x59d/0xb00
  worker_thread+0x8f/0x5c0
  kthread+0x1fc/0x230
  ret_from_fork+0x1f/0x30
==================================================================

I think this is a regression. This happened with commit a17a1faf5d3e
("RDMA/cma: Fix listener leak in rdma_cma_listen_on_all() failure").

Thanks,

Bart.
