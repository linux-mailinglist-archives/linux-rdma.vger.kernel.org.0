Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7667CCEFB
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Oct 2023 23:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjJQVOt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Oct 2023 17:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbjJQVOs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Oct 2023 17:14:48 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A132F0;
        Tue, 17 Oct 2023 14:14:46 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-57b68556d6dso3430642eaf.1;
        Tue, 17 Oct 2023 14:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697577285; x=1698182085; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GWGHXMddC3eu03dmTJfo0/ucXslCewKBsFr5sgznBvU=;
        b=Osvh7XExJ5m19SzMJnl9WPcnL0/LyTKNOXnOjzjj/tf6api0Mo1tXM7FDwBVEp/Ka9
         bSjQeTY3FVxLgG9tX3xGEtm5e2lfk3peq778MJ9QbqfjGrZTZ/d825Xkm9kNLT4uR0CQ
         2/0wFwwET/GOEq72Cau8bWhb4Wi3psVSrDFOncA/i5KtAI+bModRe1BJjgVqz4zxUfXL
         PrjVKg6mo4hGG6HEQJEZxt34nvykTC5kjbCkm7HABPQZYGoyMOG7z7qlJPWXePXv3Sw0
         WMVVxLS7r8ymvxxiRmHL+BtJfJGitvGGkvAI7ilwA2lHT+CVtZG3fsmo3mQ7m+iFHxs6
         zazw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697577285; x=1698182085;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GWGHXMddC3eu03dmTJfo0/ucXslCewKBsFr5sgznBvU=;
        b=Qlnrqhoet3BnLIIuu3CwOFQJpTP0NyCic6NCmP5uWA7IE2bTO1GwEc0S88miUzQmTM
         RJA5bBqV6KmPqDupAQpriZ1l4EWSGIeDJFiGmmk5/WvA7tXY4+KhrkemDygFT+T3J2Kk
         Yy3II39lwdLpsDuGM7td/03nAlFPubOXM2/lenonNRnrxbxJmzZAUyWAuwuPPIqg65k+
         Ir99nhRc1xWst33lqr77bQ8dZ0Js3UVNzg1vhsPy/iZ2cs2J9k8hqFUmr3vI0S9RE1jp
         swdkLIL0v/pTxsqGkLEJdf+bWzTYrnQDbyvsrAYE7+jD15bQ78HCORQycrQJ3EqwGfDC
         vCQQ==
X-Gm-Message-State: AOJu0YyEc24ykytp3B+mRoJ74h2aGzb/jQb5rIEpfU73HrVj9dAtqP48
        WF+DGHM85iqLPPPRe1HIdbxgII13q9U=
X-Google-Smtp-Source: AGHT+IH0SaC0T6i2PzRsMR422SncDL+zkefCaUChnUWGbK8D2oEkgBjBHalcLK+HIzybJorUqPDsBA==
X-Received: by 2002:a05:6820:408:b0:57d:e76d:c206 with SMTP id o8-20020a056820040800b0057de76dc206mr3519670oou.1.1697577285267;
        Tue, 17 Oct 2023 14:14:45 -0700 (PDT)
Received: from ?IPV6:2603:8081:1405:679b:1392:8eda:4bf:b7e5? (2603-8081-1405-679b-1392-8eda-04bf-b7e5.res6.spectrum.com. [2603:8081:1405:679b:1392:8eda:4bf:b7e5])
        by smtp.gmail.com with ESMTPSA id 2-20020a4ae1a2000000b00581dd3eb895sm282258ooy.37.2023.10.17.14.14.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 14:14:44 -0700 (PDT)
Message-ID: <e3d91c4f-b124-4031-9f92-fcb61973a645@gmail.com>
Date:   Tue, 17 Oct 2023 16:14:43 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] blktests srp/002 hang
To:     Bart Van Assche <bvanassche@acm.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        'Rain River' <rain.1986.08.12@gmail.com>,
        Zhu Yanjun <yanjun.zhu@linux.dev>,
        "leon@kernel.org" <leon@kernel.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
References: <8aff9124-85c0-8e3b-dc35-1017b1540037@gmail.com>
 <3c84da83-cdbb-3326-b3f0-b2dee5f014e0@linux.dev>
 <4e7aac82-f006-aaa7-6769-d1c9691a0cec@gmail.com>
 <CAJr_XRCFuv_XO3Zk+pfq6C73CgDsnaJT4-G-jq1ds3bdg76iEA@mail.gmail.com>
 <OS7PR01MB1180450455E624D5CD977C461E5FCA@OS7PR01MB11804.jpnprd01.prod.outlook.com>
 <29c5de53-cc61-4efc-8e8d-690e27756a16@acm.org>
 <OS7PR01MB118045AD711E93D223DCD6F17E5C3A@OS7PR01MB11804.jpnprd01.prod.outlook.com>
 <a3be5e98-e783-4108-a690-acc8a5cc5981@gmail.com>
 <20231017175821.GG282036@ziepe.ca>
 <8801fc68-0e8e-4bb1-acaa-597bf72a567d@gmail.com>
 <20231017185139.GA691768@ziepe.ca>
 <c65f92b2-9821-4349-b1f5-7dc2a287946a@gmail.com>
 <08a8d947-25b5-434c-9ba3-282d298b5bfd@acm.org>
Content-Language: en-US
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <08a8d947-25b5-434c-9ba3-282d298b5bfd@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/17/23 15:06, Bart Van Assche wrote:
> On 10/17/23 12:55, Bob Pearson wrote:
>> Well.... the extra tracing did *not* show srp running out of iu's.
>> So I converted cq handling to IB_POLL_SOFTIRQ from IB_POLL_DIRECT.
>> This required adding a spinlock around list_add(&iu->list, ...) in
>> srp_send_done(). The test now runs with all the completions handled
>> correctly. But, it still hangs. So a red herring.
> 
> iu->list manipulations are protected by ch->lock. See also the
> lockdep_assert_held(&ch->lock) statements in the code that does
> manipulate this list and that does not grab ch->lock directly.
> 
> Thanks,
> 
> Bart.

One more clue. When the test hangs, after 120 seconds there is a set
of hung task messages in the logs like:

[  408.844422] ib_srp:srp_parse_in: ib_srp: [fe80::b62e:99ff:fef9:fa2e] -> [fe80::b62e:99ff:fef9:fa2e]:0/11010381%0
[  408.844439] ib_srp:srp_parse_in: ib_srp: [fe80::b62e:99ff:fef9:fa2e]:5555 -> [fe80::b62e:99ff:fef9:fa2e]:5555/11010381%0
[  408.844474] ib_srp:srp_parse_in: ib_srp: [fe80::21bb:9ba3:7562:5fb8%2] -> [fe80::21bb:9ba3:7562:5fb8]:0/11010381%2
[  408.844491] ib_srp:srp_parse_in: ib_srp: [fe80::21bb:9ba3:7562:5fb8%2]:5555 -> [fe80::21bb:9ba3:7562:5fb8]:5555/11010381%2
[  408.844502] scsi host13: ib_srp: Already connected to target port with id_ext=b62e99fffef9fa2e;ioc_guid=b62e99fffef9fa2e;dest=fe80:0000:0000:0000:21bb:9ba3:7562:5fb8
[  605.106839] INFO: task kworker/1:0:25 blocked for more than 120 seconds.
[  605.106857]       Tainted: G    B      OE      6.6.0-rc3+ #10
[  605.106866] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  605.106872] task:kworker/1:0     state:D stack:0     pid:25    ppid:2      flags:0x00004000
[  605.106887] Workqueue: dio/dm-5 iomap_dio_complete_work
[  605.106904] Call Trace:
[  605.106909]  <TASK>
[  605.106917]  ? __schedule+0x996/0x2c80
[  605.106929]  __schedule+0x9f6/0x2c80
[  605.106945]  ? lock_release+0xc1/0x6f0
[  605.106955]  ? rcu_is_watching+0x23/0x50
[  605.106970]  ? io_schedule_timeout+0xc0/0xc0
[  605.106981]  ? lock_contended+0x740/0x740
[  605.106989]  ? do_raw_spin_lock+0x1c0/0x1c0
[  605.106999]  ? lock_contended+0x740/0x740
[  605.107011]  ? _raw_spin_unlock_irq+0x27/0x60
[  605.107023]  ? trace_hardirqs_on+0x22/0x100
[  605.107037]  ? _raw_spin_unlock_irq+0x27/0x60
[  605.107052]  schedule+0x96/0x150
[  605.107063]  bit_wait+0x1c/0xa0
[  605.107074]  __wait_on_bit+0x42/0x110
[  605.107084]  ? bit_wait_io+0xa0/0xa0
[  605.107099]  __inode_wait_for_writeback+0x11b/0x190
[  605.107112]  ? inode_prepare_wbs_switch+0x160/0x160
[  605.107127]  ? swake_up_one+0xb0/0xb0
[  605.107147]  writeback_single_inode+0xb8/0x250
[  605.107159]  sync_inode_metadata+0xa2/0xe0
[  605.107168]  ? write_inode_now+0x160/0x160
[  605.107186]  ? file_write_and_wait_range+0x54/0xe0
[  605.107199]  generic_buffers_fsync_noflush+0x135/0x160
[  605.107213]  ext4_sync_file+0x3b3/0x620
[  605.107227]  vfs_fsync_range+0x69/0x110
[  605.107237]  ? ext4_getfsmap+0x520/0x520
[  605.107249]  iomap_dio_complete+0x35c/0x3a0
[  605.107259]  ? __schedule+0x9fe/0x2c80
[  605.107272]  ? aio_fsync_work+0x190/0x190
[  605.107284]  iomap_dio_complete_work+0x36/0x50
[  605.107297]  process_one_work+0x46c/0x950


All the active threads are just the same and are all waiting for
an io to complete from scsi. No threads are active in rxe, srp(t)
or scsi. All activity appears to be dead.

Bob
