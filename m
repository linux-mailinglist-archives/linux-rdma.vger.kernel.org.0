Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02C821DF11A
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2020 23:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731069AbgEVV3T (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 May 2020 17:29:19 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37770 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731029AbgEVV3T (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 May 2020 17:29:19 -0400
Received: by mail-pl1-f194.google.com with SMTP id x10so4916208plr.4
        for <linux-rdma@vger.kernel.org>; Fri, 22 May 2020 14:29:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:autocrypt:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=Zu9TtYaGPQRqjA10ZFHD1Ua+x7ttcHaqtk/Waqa0K5A=;
        b=DH3AVibTTHERH+H7yMjRrjcakLZdiY2s/Cy3Lbw5PU3co665lh4jnzPf1ja57MqElp
         qRzYgu8EVnXqxTmxB6jb6m4rbYVF3nhC7miJLOBzJ1PR+lpAEnfnrEQBQBsvG68wysK6
         AM9MhCP6T9zmfShGSO9R12mGQfe8izn5UAbLlRrPyoqK9l8NpLpUvAaNoYwtmyCkgeBD
         SmbB0+abePGEl5VURxbC8sWIqnSmWsyQu9CCNrAUJp19eLAXuNtBDYQXMJCKAieYJBH+
         gHxfUD6dRgK4NDpLaCnWR95O27O3RLe1E8HoViNjJjztc+yAa44L3uCVEs4Vvbh38rTz
         Mgfw==
X-Gm-Message-State: AOAM533P2sBVSmMuU6Yk6n7IS/+pSzN0lU3JV3q3VwrA8/ULcRX6MNkm
        jW0eBbcMTQB0DW1mfy5Jnb6UNyWN
X-Google-Smtp-Source: ABdhPJzZFYJH9QFCEalKDxnPyFSkkmz+cdVVFv1jD4UI/CIJiEZxZwMJbKYg7pM/PHPC4iKK6E/JIA==
X-Received: by 2002:a17:90a:3462:: with SMTP id o89mr6853713pjb.189.1590182957827;
        Fri, 22 May 2020 14:29:17 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:b874:274b:7df6:e61b? ([2601:647:4000:d7:b874:274b:7df6:e61b])
        by smtp.gmail.com with ESMTPSA id t10sm7522999pjj.19.2020.05.22.14.29.16
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2020 14:29:17 -0700 (PDT)
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
Subject: rdma-for-next lockdep complaint
Autocrypt: addr=bvanassche@acm.org; prefer-encrypt=mutual; keydata=
 mQENBFSOu4oBCADcRWxVUvkkvRmmwTwIjIJvZOu6wNm+dz5AF4z0FHW2KNZL3oheO3P8UZWr
 LQOrCfRcK8e/sIs2Y2D3Lg/SL7qqbMehGEYcJptu6mKkywBfoYbtBkVoJ/jQsi2H0vBiiCOy
 fmxMHIPcYxaJdXxrOG2UO4B60Y/BzE6OrPDT44w4cZA9DH5xialliWU447Bts8TJNa3lZKS1
 AvW1ZklbvJfAJJAwzDih35LxU2fcWbmhPa7EO2DCv/LM1B10GBB/oQB5kvlq4aA2PSIWkqz4
 3SI5kCPSsygD6wKnbRsvNn2mIACva6VHdm62A7xel5dJRfpQjXj2snd1F/YNoNc66UUTABEB
 AAG0JEJhcnQgVmFuIEFzc2NoZSA8YnZhbmFzc2NoZUBhY20ub3JnPokBOQQTAQIAIwUCVI67
 igIbAwcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEHFcPTXFzhAJ8QkH/1AdXblKL65M
 Y1Zk1bYKnkAb4a98LxCPm/pJBilvci6boefwlBDZ2NZuuYWYgyrehMB5H+q+Kq4P0IBbTqTa
 jTPAANn62A6jwJ0FnCn6YaM9TZQjM1F7LoDX3v+oAkaoXuq0dQ4hnxQNu792bi6QyVdZUvKc
 macVFVgfK9n04mL7RzjO3f+X4midKt/s+G+IPr4DGlrq+WH27eDbpUR3aYRk8EgbgGKvQFdD
 CEBFJi+5ZKOArmJVBSk21RHDpqyz6Vit3rjep7c1SN8s7NhVi9cjkKmMDM7KYhXkWc10lKx2
 RTkFI30rkDm4U+JpdAd2+tP3tjGf9AyGGinpzE2XY1K5AQ0EVI67igEIAKiSyd0nECrgz+H5
 PcFDGYQpGDMTl8MOPCKw/F3diXPuj2eql4xSbAdbUCJzk2ETif5s3twT2ER8cUTEVOaCEUY3
 eOiaFgQ+nGLx4BXqqGewikPJCe+UBjFnH1m2/IFn4T9jPZkV8xlkKmDUqMK5EV9n3eQLkn5g
 lco+FepTtmbkSCCjd91EfThVbNYpVQ5ZjdBCXN66CKyJDMJ85HVr5rmXG/nqriTh6cv1l1Js
 T7AFvvPjUPknS6d+BETMhTkbGzoyS+sywEsQAgA+BMCxBH4LvUmHYhpS+W6CiZ3ZMxjO8Hgc
 ++w1mLeRUvda3i4/U8wDT3SWuHcB3DWlcppECLkAEQEAAYkBHwQYAQIACQUCVI67igIbDAAK
 CRBxXD01xc4QCZ4dB/0QrnEasxjM0PGeXK5hcZMT9Eo998alUfn5XU0RQDYdwp6/kMEXMdmT
 oH0F0xB3SQ8WVSXA9rrc4EBvZruWQ+5/zjVrhhfUAx12CzL4oQ9Ro2k45daYaonKTANYG22y
 //x8dLe2Fv1By4SKGhmzwH87uXxbTJAUxiWIi1np0z3/RDnoVyfmfbbL1DY7zf2hYXLLzsJR
 mSsED/1nlJ9Oq5fALdNEPgDyPUerqHxcmIub+pF0AzJoYHK5punqpqfGmqPbjxrJLPJfHVKy
 goMj5DlBMoYqEgpbwdUYkH6QdizJJCur4icy8GUNbisFYABeoJ91pnD4IGei3MTdvINSZI5e
Message-ID: <70057e07-abd3-0254-1566-8c489cfa1c5f@acm.org>
Date:   Fri, 22 May 2020 14:29:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

If I run test srp/015 from the blktests test suite then the lockdep complaint
shown below is reported. Since I haven't seen this complaint in the past I
think that this is a regression. This complaint was triggered by the code on
the for-next branch of
git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git. Is this a known
issue?

Thanks,

Bart.

============================================
WARNING: possible recursive locking detected
5.7.0-rc1-dbg+ #1 Not tainted
--------------------------------------------
kworker/u16:3/169 is trying to acquire lock:
ffff8881e54803b8 (&id_priv->handler_mutex){+.+.}-{3:3}, at: rdma_destroy_id+0xb7/0x610 [rdma_cm]

but task is already holding lock:
ffff8881e6af03b8 (&id_priv->handler_mutex){+.+.}-{3:3}, at: iw_conn_req_handler+0x147/0x760 [rdma_cm]

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&id_priv->handler_mutex);
  lock(&id_priv->handler_mutex);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

3 locks held by kworker/u16:3/169:
 #0: ffff8881e2a8a938 ((wq_completion)iw_cm_wq){+.+.}-{0:0}, at: process_one_work+0x48b/0xb70
 #1: ffffc90000457dd8 ((work_completion)(&work->work)#4){+.+.}-{0:0}, at: process_one_work+0x48f/0xb70
 #2: ffff8881e6af03b8 (&id_priv->handler_mutex){+.+.}-{3:3}, at: iw_conn_req_handler+0x147/0x760 [rdma_cm]

stack backtrace:
CPU: 3 PID: 169 Comm: kworker/u16:3 Not tainted 5.7.0-rc1-dbg+ #1
Workqueue: iw_cm_wq cm_work_handler [iw_cm]
Call Trace:
 dump_stack+0xa5/0xe6
 validate_chain.cold+0x182/0x187
 __lock_acquire+0x7db/0xee0
 lock_acquire+0x198/0x630
 __mutex_lock+0x12e/0xe60
 mutex_lock_nested+0x1f/0x30
 rdma_destroy_id+0xb7/0x610 [rdma_cm]
 iw_conn_req_handler+0x50b/0x760 [rdma_cm]
 cm_work_handler+0xe28/0x1080 [iw_cm]
 process_one_work+0x586/0xb70
 worker_thread+0x7a/0x5d0
 kthread+0x211/0x240
 ret_from_fork+0x24/0x30
