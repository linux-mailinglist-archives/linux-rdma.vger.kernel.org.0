Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52EF67CCF10
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Oct 2023 23:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjJQVSY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Oct 2023 17:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJQVSY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Oct 2023 17:18:24 -0400
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31CBC6;
        Tue, 17 Oct 2023 14:18:22 -0700 (PDT)
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-578d0dcd4e1so3721605a12.2;
        Tue, 17 Oct 2023 14:18:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697577502; x=1698182302;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bQ82Bm7evAjsL/13PLp78PKiqovnxu/zB5FMTkae+bI=;
        b=iHO6d/wxOO0FFq0k53YVXJkoAnqG0rh7sHM8QWxAllLG9+ump3wn8e0ymfaOqTisQx
         zgomsdn7THhCXyQhl0vBGYShddtUDhKSu7wXWHxjvpLy38TOuyLIM/InnGA5QipDfPDS
         u5Xhd7Pbd5OyhrA7VXBlTuLXvT+GWzNSfjrcYs78j7DSqHKlzs2mchjBis89YEltkEdd
         xwCOWJoexViVlvsdS5fe2kPn2zYLja6GTDGdVngdYX26dQcgyg993eHP/lvBAyvCPBpO
         tBHS0ZaKsagpAqiqixoi0zCeXw6386oevAO5M3zF+wDMlnUoojw1NW1LL84Hi/LVksBD
         TqVA==
X-Gm-Message-State: AOJu0YxcqADVLijwTqO41X3I8lZhFz2LndoFERFIHX8iSoe3R9aswL/w
        6RFd04JDhwFIzdxYLVdei0o=
X-Google-Smtp-Source: AGHT+IH5qc+IN0AUHe2oW/f8CG3Kh/fBdM2mrxXk3FM/9FpSBtoVNEIqZAkV3tLp81qOKobkf7R+cA==
X-Received: by 2002:a05:6a21:7906:b0:179:f858:784d with SMTP id bg6-20020a056a21790600b00179f858784dmr3249538pzc.21.1697577502130;
        Tue, 17 Oct 2023 14:18:22 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:8f02:2919:9600:ac09? ([2620:15c:211:201:8f02:2919:9600:ac09])
        by smtp.gmail.com with ESMTPSA id jf22-20020a170903269600b001c71ec1866fsm2045225plb.258.2023.10.17.14.18.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 14:18:21 -0700 (PDT)
Message-ID: <02cd10fd-fd4a-4ad7-9b1d-6d37b070aacf@acm.org>
Date:   Tue, 17 Oct 2023 14:18:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] blktests srp/002 hang
Content-Language: en-US
To:     Bob Pearson <rpearsonhpe@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>
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
 <e3d91c4f-b124-4031-9f92-fcb61973a645@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <e3d91c4f-b124-4031-9f92-fcb61973a645@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 10/17/23 14:14, Bob Pearson wrote:
> All the active threads are just the same and are all waiting for
> an io to complete from scsi. No threads are active in rxe, srp(t)
> or scsi. All activity appears to be dead.

Is this really a clue? I have seen such backtraces many times. All
such a backtrace tells us is that something got stuck in a layer
under the filesystem. It does not tell us which layer caused
command processing to get stuck.

Bart.

