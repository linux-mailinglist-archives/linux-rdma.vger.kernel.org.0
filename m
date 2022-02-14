Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4063A4B588E
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Feb 2022 18:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235704AbiBNRey (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Feb 2022 12:34:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233371AbiBNRey (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Feb 2022 12:34:54 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852B265406;
        Mon, 14 Feb 2022 09:34:45 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id h7-20020a17090a648700b001b927560c2bso15334518pjj.1;
        Mon, 14 Feb 2022 09:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=apnN0rYl+OR6PUK+71gKAmUuuy1MXm8SpHDSHheapQc=;
        b=PkE0ZISIikKihgqyEmgleK5vFffN7Dkqf+BF3fP4eiTxUPbO/8pgH7SrrohSTNwDo6
         9XL56ttmwbdIASNROorrTUwJvIi4KVku9jrN7MqG9zT5/1z9/l657DXYzmIkmlTpwOQW
         vHlesGH7u7cvgrnz+ofvIkYcW2SlBfX+bUzfmtA0gvmWOu4x+xFo4dnom7tPC/cm5+42
         KPVu9awJq9D0OX1PZAMXzcoBG0Gc3vy8g0zN8m4mOpMRKAd+6pYJsMFWDxTjV9+qjrMb
         QFha5efL6bPmTlNgYYlBz4eKLGj+T3aPIMOhDEdPNVYsDmU8a0resxFefm6YNQT5audI
         GWMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=apnN0rYl+OR6PUK+71gKAmUuuy1MXm8SpHDSHheapQc=;
        b=6BzX3bzzHHy9lzuFsJSwUE/kVUcdO6lPFVX9ArABPMCj9AFYULkITtxV6Q3zkytOfB
         NrvQnYzjoTcX/7T12zreTzM41W90y9hx3wkZRcd/+D0+ot8X5kH0m0RYb37Im67ErvB/
         2kxEMSMZCUUN5EcoWae5ABKaEaNbGL+4QSX1sl2FY/yO/RLblYXZOZX3ZEIUTQ9paMNh
         zSQwc5fFqwbQIe86Gofm5q+MxMXRTJlzNLqZfdteB5T6lTPpwuAKUP+IUWh6jPBuW5qT
         fHJrMWq4ttIez7P9+59qPR/J1Is1GeXIsOBtfAbp8Uf+FO6nLudaqjitIwNn0zi7eF70
         k3JA==
X-Gm-Message-State: AOAM532sWL452tLQPc8wB1r7tzWs9cSujVUZ1k1UoiJZyRXqXLktq1m1
        roj2HEWLCDSivgbpZ/4OodH0PKUgZi8=
X-Google-Smtp-Source: ABdhPJxQmVTzKYH18qIy9otiYAlZ8hossATt3HpXdW1A0Xc0VYFl+e1UaTk5hbPT5gPJn+8sxJGFyw==
X-Received: by 2002:a17:903:22d0:: with SMTP id y16mr790620plg.107.1644860084808;
        Mon, 14 Feb 2022 09:34:44 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id a9sm184432pgb.56.2022.02.14.09.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 09:34:44 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 14 Feb 2022 07:34:42 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        syzbot <syzbot+831661966588c802aae9@syzkaller.appspotmail.com>,
        jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [syzbot] possible deadlock in worker_thread
Message-ID: <YgqSsuSN5C7StvKx@slm.duckdns.org>
References: <0000000000005975a605d7aef05e@google.com>
 <8ea57ddf-a09c-43f2-4285-4dfb908ad967@acm.org>
 <ccd04d8a-154b-543e-e1c3-84bc655508d1@I-love.SAKURA.ne.jp>
 <71d6f14e-46af-cc5a-bc70-af1cdc6de8d5@acm.org>
 <309c86b7-2a4c-1332-585f-7bcd59cfd762@I-love.SAKURA.ne.jp>
 <aa2bf24e-981a-a811-c5d8-a75f0b8f693a@acm.org>
 <2959649d-cfbc-bdf2-02ac-053b8e7af030@I-love.SAKURA.ne.jp>
 <YgnQGZWT/n3VAITX@slm.duckdns.org>
 <8ebd003c-f748-69b4-3a4f-fb80a3f39d36@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ebd003c-f748-69b4-3a4f-fb80a3f39d36@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello,

On Mon, Feb 14, 2022 at 10:36:57PM +0900, Tetsuo Handa wrote:
> OK. Then, I propose below patch. If you are OK with this approach, I can
> keep this via my tree as a linux-next only experimental patch for one or
> two weeks, in order to see if someone complains.

I don't mind you testing that way but this and would much prefer this and
related changes in the wq tree.

> +static void warn_if_flushing_global_workqueue(struct workqueue_struct *wq)
> +{
> +#ifdef CONFIG_PROVE_LOCKING
> +	static DEFINE_RATELIMIT_STATE(flush_warn_rs, 600 * HZ, 1);
> +	const char *name;
> +
> +	if (wq == system_wq)
> +		name = "system_wq";
> +	else if (wq == system_highpri_wq)
> +		name = "system_highpri_wq";
> +	else if (wq == system_long_wq)
> +		name = "system_long_wq";
> +	else if (wq == system_unbound_wq)
> +		name = "system_unbound_wq";
> +	else if (wq == system_freezable_wq)
> +		name = "system_freezable_wq";
> +	else if (wq == system_power_efficient_wq)
> +		name = "system_power_efficient_wq";
> +	else if (wq == system_freezable_power_efficient_wq)
> +		name = "system_freezable_power_efficient_wq";
> +	else
> +		return;
> +	ratelimit_set_flags(&flush_warn_rs, RATELIMIT_MSG_ON_RELEASE);
> +	if (!__ratelimit(&flush_warn_rs))
> +		return;
> +	pr_warn("Since system-wide WQ is shared, flushing system-wide WQ can introduce unexpected locking dependency. Please replace %s usage in your code with your local WQ.\n",
> +		name);
> +	dump_stack();
> +#endif

Instead of doing the above, please add a wq flag to mark system wqs and
trigger the warning that way and I'd leave it regardless of PROVE_LOCKING.

Thanks.

-- 
tejun
