Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 143987643B4
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jul 2023 04:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjG0CLI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Jul 2023 22:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjG0CLH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 Jul 2023 22:11:07 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA431FC2;
        Wed, 26 Jul 2023 19:11:05 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-686efdeabaeso317821b3a.3;
        Wed, 26 Jul 2023 19:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690423865; x=1691028665;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cvO/SSTX/RJfVRWoJjupWhRCvEyYV01fI2j/IhxZ090=;
        b=eppjM8BTFRCYyNs0+hqqPoUamkRvgKF9wqRnAQS+P5B/oVn4bAOGdq2Un8JIas+D8s
         SIgDSfW7eTsPkqdA2c5L3Im3ovEeOgO296ZTPYd3WKkFjr+cFRmulU/R9+PZIU0hs/wm
         r63fCh+Gn/efTdFusPj9Ie46ffkFisSRd7P+hb6YHCRraf7+8LpFzK3Z/k+xdJ0Pvu7U
         qPNwKlmGJbyIE9V4ziRbPAgGsW4+XABZPuEVtUO8gBzIJyerHkGPhM5QVeYn2cPFfvos
         EAwcRpDlnvcOOt3rjBbCJd99K31tkwPSeTukgGZ6Aa+aPp776dJeHc3SOHmqxDIvgdoo
         6Qqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690423865; x=1691028665;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cvO/SSTX/RJfVRWoJjupWhRCvEyYV01fI2j/IhxZ090=;
        b=iMvYeFRmaCmXIizRVqGtuaSkXlLLu+zEsmM4XbNG5gBG4qja1Gn/eIh/DUkekVWgGh
         t1TdcxrehXqK//7EJRdEik6DBiPPwm4/A/5VGA/xcnz5rf0nKEPfTc1xwkX/z+OaYhC+
         IzXqoO7HAUridi8zYlPhUh2w8jTQuQHhyg5SR8SsGc7KwozzO1UCVOnuInXId9Ql3kA+
         cCOlBMLq5S706mROOOJLVvhpYGAJLBp36s6MD6meYOot4llxkmMRmdOTsZkZ/wWPHB0j
         LME+aQ5E3gVOo9DQPy0Qp96s0MpJAa2igJcPI7rv+2enAvk7cwvlHniSkGIaIPrR4O3m
         UvjQ==
X-Gm-Message-State: ABy/qLbEgkFbIm2Ln/duWlmInhlwc8jLxD5CBBek9v/mkOyJ+VUAnXPM
        e317+gCebBqc4wHr4/fUikE=
X-Google-Smtp-Source: APBJJlFaT25G5eZNuUB4df060xaex9EsMM+qAK+cT71OqCPtUmg5AAf2OcdDlzE2SUH5W0MHYG7TEg==
X-Received: by 2002:a05:6a20:2591:b0:135:8a04:9045 with SMTP id k17-20020a056a20259100b001358a049045mr3878961pzd.1.1690423864850;
        Wed, 26 Jul 2023 19:11:04 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id j6-20020a170902c3c600b001b857352285sm221874plj.247.2023.07.26.19.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 19:11:04 -0700 (PDT)
Date:   Wed, 26 Jul 2023 19:11:01 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Saeed Mahameed <saeedm@nvidia.com>,
        Pawel Chmielewski <pawel.chmielewski@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tariq Toukan <tariqt@nvidia.com>,
        Gal Pressman <gal@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Barry Song <baohua@kernel.org>
Subject: Re: [PATCH v3 8/8] lib: test for_each_numa_cpus()
Message-ID: <ZMHSNQfv39HN068m@yury-ThinkPad>
References: <20230430171809.124686-1-yury.norov@gmail.com>
 <20230430171809.124686-9-yury.norov@gmail.com>
 <68e850c3-bde7-45f2-9d9e-24aea1f2386b@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68e850c3-bde7-45f2-9d9e-24aea1f2386b@roeck-us.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Jul 22, 2023 at 08:47:16AM -0700, Guenter Roeck wrote:
> Hi,
> 
> On Sun, Apr 30, 2023 at 10:18:09AM -0700, Yury Norov wrote:
> > Test for_each_numa_cpus() output to ensure that:
> >  - all CPUs are picked from NUMA nodes with non-decreasing distances to the
> >    original node; 
> >  - only online CPUs are enumerated;
> >  - the macro enumerates each online CPUs only once;
> >  - enumeration order is consistent with cpumask_local_spread().
> > 
> > The latter is an implementation-defined behavior. If cpumask_local_spread()
> > or for_each_numa_cpu() will get changed in future, the subtest may need
> > to be adjusted or even removed, as appropriate.
> > 
> > It's useful now because some architectures don't implement numa_distance(),
> > and generic implementation only distinguishes local and remote nodes, which
> > doesn't allow to test the for_each_numa_cpu() properly.
> > 
> 
> This patch results in a crash when testing sparc64 images with qemu.

Thanks Guenter for reporting. I'll remove the series until fixing the
issue.

Thanks,
Yury
