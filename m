Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35387D24A4
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Oct 2023 18:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbjJVQs4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 22 Oct 2023 12:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjJVQsz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 22 Oct 2023 12:48:55 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D708E7;
        Sun, 22 Oct 2023 09:48:53 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-357cd72e07fso3824805ab.2;
        Sun, 22 Oct 2023 09:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697993332; x=1698598132; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jF3SNiK0KMBKYvlHwQNCi3aly8Uzbv+Ykz8y7917xGo=;
        b=ZQTfFOTKu+U8niPq0Bj7RX208WeXO0AvDlQ4wzW8Wbdyx4d/b74ih4Wtf4PnSoJ2yS
         zY2vWQOt9oZOvzmda1vtrmTci9bdCx+tUcu/tUxPp3LOnSwzIFqUAlSAN/kbi+EaLFWI
         TLkmZuS30dRwZOi9NjDmRuu6uGV6X7Di7VUOcMbVXiB9MqjJROxV2HHdaxOHKS6pCRmG
         FOCXI1Yj0jd1MFms64TAVb57oGbetAF9JS/92u/DgpSYhsheldBIeChrcD75YLr0QCK7
         i2yn9EAbEbCXZDvAy1HwPL2jfkMfj4n7UoF6hqOcK5UG8ju80dWdZox6q1Pje45WHH8p
         S1Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697993332; x=1698598132;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jF3SNiK0KMBKYvlHwQNCi3aly8Uzbv+Ykz8y7917xGo=;
        b=YBlHKlxjDALod0fYe1t6RGHSUdty76J/zcgaD0x3dRZTE1Bid/KRBlEGdqJqGzDdwp
         +kli1SbYUki5l6fpFDHiQnsIBmmGcfEmDVNN2jykQo0iqBwPEGgzHPWphF41QTokUMZp
         Udp0V4v0G5Bvbg29mJd68icNB+tORwh+HrX9eu7AKU9PzrPExlVElG/zbwk/gp99JYQY
         EZLa1hO76QYpU57csynDw79Hif8Wby30HuadeZWF0wjVRQ4/9gOdCrNZSv0kr77cRv3p
         Sw+N7M6qIKgSHDcq26SOiulFE2GWkeWN7uwhtq4u6+bFlxEPEm+HLFo+FG3IEIkIimo+
         xoEQ==
X-Gm-Message-State: AOJu0YyD791ghZGk5vdfwNsGu/XUWvIeZVapxg6ZEHVLI8aItBbLU8uf
        B0kSKJmRQCeAsgCTgHxEDSu7+KeRTvU=
X-Google-Smtp-Source: AGHT+IEJkSDVETG9W+NzprLNw9D45ruzt3pBbrHLsIX0kV4SYpAzKRrmSDN1RQfNdNwSOufMA3eTVQ==
X-Received: by 2002:a05:6e02:20e5:b0:357:d0b8:c4dc with SMTP id q5-20020a056e0220e500b00357d0b8c4dcmr2044871ilv.19.1697993332334;
        Sun, 22 Oct 2023 09:48:52 -0700 (PDT)
Received: from ?IPV6:2601:282:1e82:2350:80d6:b9fd:f23f:cfa9? ([2601:282:1e82:2350:80d6:b9fd:f23f:cfa9])
        by smtp.googlemail.com with ESMTPSA id m18-20020a92c532000000b0035298bd42a8sm2002923ili.20.2023.10.22.09.48.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Oct 2023 09:48:51 -0700 (PDT)
Message-ID: <bc9f53d2-2d40-4c7e-85fa-cb9835df9159@gmail.com>
Date:   Sun, 22 Oct 2023 10:48:50 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next 2/3] rdma: Add an option to set privileged
 QKEY parameter
To:     Patrisious Haddad <phaddad@nvidia.com>,
        Petr Machata <petrm@nvidia.com>
Cc:     jgg@ziepe.ca, leon@kernel.org, stephen@networkplumber.org,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com, linux-kernel@vger.kernel.org,
        huangjunxian6@hisilicon.com, michaelgur@nvidia.com
References: <20231019082138.18889-1-phaddad@nvidia.com>
 <20231019082138.18889-3-phaddad@nvidia.com> <87il72aiqm.fsf@nvidia.com>
 <c7c9562a-5c6d-eec5-3255-70238a13e96c@nvidia.com>
Content-Language: en-US
From:   David Ahern <dsahern@gmail.com>
In-Reply-To: <c7c9562a-5c6d-eec5-3255-70238a13e96c@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/22/23 1:41 AM, Patrisious Haddad wrote:
> 
> On 10/19/2023 1:38 PM, Petr Machata wrote:
>> Patrisious Haddad <phaddad@nvidia.com> writes:
>>
>>> @@ -40,6 +45,22 @@ static int sys_show_parse_cb(const struct nlmsghdr
>>> *nlh, void *data)
>>>                      mode_str);
>>>       }
>>>   +    if (tb[RDMA_NLDEV_SYS_ATTR_PRIVILEGED_QKEY_MODE]) {
>>> +        const char *pqkey_str;
>>> +        uint8_t pqkey_mode;
>>> +
>>> +        pqkey_mode =
>>> +           
>>> mnl_attr_get_u8(tb[RDMA_NLDEV_SYS_ATTR_PRIVILEGED_QKEY_MODE]);
>>> +
>>> +        if (pqkey_mode < ARRAY_SIZE(privileged_qkey_str))
>>> +            pqkey_str = privileged_qkey_str[pqkey_mode];
>>> +        else
>>> +            pqkey_str = "unknown";
>>> +
>>> +        print_color_string(PRINT_ANY, COLOR_NONE, "privileged-qkey",
>>> +                   "privileged-qkey %s ", pqkey_str);
>>> +    }
>>> +
>> Elsewhere in the file, you just use print_color_on_off(), why not here?
> 
> The print_color_on_off was used for copy-on-fork which as you see has no
> set function,
> 
> I was simply trying to be consistent with this file convention & style,
> whereas print_color_string was used for the other configurable value
> ("netns"), I can obviously change that if you all see it as necessary.
> 
>>
>>>       if (tb[RDMA_NLDEV_SYS_ATTR_COPY_ON_FORK])
>>>           cof = mnl_attr_get_u8(tb[RDMA_NLDEV_SYS_ATTR_COPY_ON_FORK]);
>>>   @@ -111,10 +155,25 @@ static int sys_set_netns_args(struct rd *rd)
>>>       return sys_set_netns_cmd(rd, cmd);
>>>   }
>>>   +static int sys_set_privileged_qkey_args(struct rd *rd)
>>> +{
>>> +    bool cmd;
>>> +
>>> +    if (rd_no_arg(rd) || !sys_valid_privileged_qkey_cmd(rd_argv(rd))) {
>>> +        pr_err("valid options are: { on | off }\n");
>>> +        return -EINVAL;
>>> +    }
>> This could use parse_on_off().
> You are absolutely correct, but just as well was trying to maintain same
> code style as the previous configurable value we have here, but I think
> using parse_on_off here can save us some code.
>>
>>> +
>>> +    cmd = (strcmp(rd_argv(rd), "on") == 0) ? true : false;
>>> +
>>> +    return sys_set_privileged_qkey_cmd(rd, cmd);
>>> +}
>>> +
>>>   static int sys_set_help(struct rd *rd)
>>>   {
>>>       pr_out("Usage: %s system set [PARAM] value\n", rd->filename);
>>>       pr_out("            system set netns { shared | exclusive }\n");
>>> +    pr_out("            system set privileged-qkey { on | off }\n");
>>>       return 0;
>>>   }
>>>   @@ -124,6 +183,7 @@ static int sys_set(struct rd *rd)
>>>           { NULL,            sys_set_help },
>>>           { "help",        sys_set_help },
>>>           { "netns",        sys_set_netns_args},
>>> +        { "privileged-qkey",    sys_set_privileged_qkey_args},
>>>           { 0 }
>>>       };
>> The rest of the code looks sane to me, but I'm not familiar with the
>> feature.
> If no one else has any comments soon, and these two comments are
> actually considered critical I can re-send my patches with those issues
> fixed.

tools packaged with iproute2 should use common code where possible.
