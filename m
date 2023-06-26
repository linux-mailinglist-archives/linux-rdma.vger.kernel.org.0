Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE58B73EC0A
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jun 2023 22:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjFZUra (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Jun 2023 16:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjFZUr3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 26 Jun 2023 16:47:29 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918D412A
        for <linux-rdma@vger.kernel.org>; Mon, 26 Jun 2023 13:47:24 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-66869feb7d1so1983502b3a.3
        for <linux-rdma@vger.kernel.org>; Mon, 26 Jun 2023 13:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1687812444; x=1690404444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kms0H0qh0BC4E2qqH9Z2kg6XISwIpNu68Rt88k6ZU9Q=;
        b=b6tD4vEHA9gzY35UuB/3ZPY6VXg3JK4i/zJQpSmzcyjmImYw3S3AZxmuC/LO7qrRHL
         0OPNSnECNq6rI1m+NTfcw5y4T4yOBrqbj14pLGLE6W/zhm7plrIW8tUujSR4hcynV1oy
         P27X5sd+Hc+Q25xcY/jY5XFyFA+6UBpUcLgqxaSBEEv4BCXrxzK7Omy2zHpQzEc/DjPR
         13neo9pSlKT+sV1tPjVkBlICkU85jivaG3EsWDBtcI4FxNBTSYwk2uMDzZdEYlvtSu6a
         NWv0o8xHVXOk9+J+HhT60qemCSboEreLuD/mxA2KGBfXxNMoI6L4H9hGxULcqImpM8Dy
         1qcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687812444; x=1690404444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kms0H0qh0BC4E2qqH9Z2kg6XISwIpNu68Rt88k6ZU9Q=;
        b=GO4SWwsaCSZAeUIswR6PhH0ZYvogTWml5Iba0gwlOWDtHeliWrCWJ+g/wfCMV/xmtd
         deQO3bMWVrw+2mt3W2jX9NtZx1/idLIs9nnyAFE+I2fYO5womVzSNgzDVONefhOP6Vs2
         JtMFMuAPQF7JmvpfBP4IflUSjKD6ZaSRwvkbK0NffLdMsB2NauKVW/T8RkzkHVKkbKFY
         /kgZPXAj0f+pbe1wWWqJLD6eKKEVif832V99Eu1cOZTbYEFG3ABS87EvDHXfD8sdDu5z
         gbJ3/8Vo3TOpRCNzcfdKqHCTOn+D5BzwpnGEcIg4GahiIRGR0/wDKCtYmBQSrcKchOub
         2utg==
X-Gm-Message-State: AC+VfDyJ+cd1XWElLPWX+Whyg4lL/pjbFfgQhKBYntsog1fjienML8XH
        dxCV8hA59gRuShhYCH3016aPtQ==
X-Google-Smtp-Source: ACHHUZ5fzWr4Vm6bBdKDmKxsox3wJmLPjxaF521aPRnVQeoeej/eMt9HBi1dHHVHz+Pmx4dFCv82Ug==
X-Received: by 2002:a17:902:c085:b0:1b6:a972:4414 with SMTP id j5-20020a170902c08500b001b6a9724414mr4558982pld.3.1687812444029;
        Mon, 26 Jun 2023 13:47:24 -0700 (PDT)
Received: from hermes.local (204-195-120-218.wavecable.com. [204.195.120.218])
        by smtp.gmail.com with ESMTPSA id k19-20020a170902ba9300b001ab39cd875csm4594066pls.133.2023.06.26.13.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 13:47:23 -0700 (PDT)
Date:   Mon, 26 Jun 2023 13:47:21 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     Simon Horman <simon.horman@corigine.com>,
        souradeep chakrabarti <schakrabarti@linux.microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        Long Li <longli@microsoft.com>,
        Ajay Sharma <sharmaajay@microsoft.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "cai.huoqing@linux.dev" <cai.huoqing@linux.dev>,
        "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Souradeep Chakrabarti <schakrabarti@microsoft.com>
Subject: Re: [PATCH 1/2 V3 net] net: mana: Fix MANA VF unload when host is
 unresponsive
Message-ID: <20230626134721.256c6c16@hermes.local>
In-Reply-To: <SA1PR21MB1335166153541BFDC2B7036BBF26A@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <1687771058-26634-1-git-send-email-schakrabarti@linux.microsoft.com>
        <1687771098-26775-1-git-send-email-schakrabarti@linux.microsoft.com>
        <ZJmNBKA3ygDryP7i@corigine.com>
        <SA1PR21MB1335166153541BFDC2B7036BBF26A@SA1PR21MB1335.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, 26 Jun 2023 20:06:48 +0000
Dexuan Cui <decui@microsoft.com> wrote:

> > From: Simon Horman
> > Sent: Monday, June 26, 2023 6:05 AM  
> > > ...
> > > Fixes: ca9c54d2d6a5ab2430c4eda364c77125d62e5e0f (net: mana: Add a
> > > driver for
> > > Microsoft Azure Network Adapter)  
> > 
> > nit: A correct format of this fixes tag is:
> > 
> > In particular:
> > * All on lone line
> > * Description in double quotes.
> > 
> > Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network
> > Adapter (MANA)")  
> 
> Hi Souradeep, FYI I often refer to:
> https://marc.info/?l=linux-pci&m=150905742808166&w=2
> 
> The link mentions:
> alias gsr='git --no-pager show -s --abbrev-commit --abbrev=12 --pretty=format:"%h (\"%s\")%n"'
> 
> "gsr ca9c54d2d6a5ab2430c4eda364c77125d62e5e0f" produces:
> ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network Adapter (MANA)")

You can do same thing without shell alias by using git-config

[alias]
	fixes = log -1 --format=fixes
	gsr = log -1 --format=gsr

[pretty]
	fixes = Fixes: %h (\"%s\")
	gsr = %h (\"%s\")

Then:
$ git gsr 1919b39fc6eabb9a6f9a51706ff6d03865f5df29
1919b39fc6ea ("net: mana: Fix perf regression: remove rx_cqes, tx_cqes counters")

