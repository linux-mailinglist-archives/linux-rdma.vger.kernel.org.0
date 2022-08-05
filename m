Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6CAF58AFF1
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Aug 2022 20:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241364AbiHESge (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 Aug 2022 14:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241438AbiHESgd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 5 Aug 2022 14:36:33 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2B2DF2
        for <linux-rdma@vger.kernel.org>; Fri,  5 Aug 2022 11:36:33 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-10ee900cce0so3824319fac.5
        for <linux-rdma@vger.kernel.org>; Fri, 05 Aug 2022 11:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=ZjuNnQI5Mx6Cu/7GKa/KAAZBCsOxEUzma4XEhgV5YzU=;
        b=Age/wjMwrMiWTGNWZE16nGjWeBowIB1dFFTJ6B1iF0yLpDGF9YDVAagK3ZdOBv167W
         HNsG8qOlUINOzRNZU2n7HA+9sJPSFhIx43vXFU/sa4HvWQz9qDMC6OcXqbvDST/hFkgl
         IWDPpONasp9gxcFsyP5HGUfSjRERh/1nvyrVM3qJ2xEBoyVy+zs44ZaQS5PapN7SR0wJ
         vfdR1Vz3SAnuyXoHbp589pZsgy9MvVYNvQq+Bv2vt+mwkqGLOPpBhZEqsC3qgDd5kq1Y
         t5ebMYxMeurGgjDqOu8DuumSdzTrXsjj2Q/EBbFSCdPIp9d9HiknoazFy2WWaIIi88ZH
         MfJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=ZjuNnQI5Mx6Cu/7GKa/KAAZBCsOxEUzma4XEhgV5YzU=;
        b=G8T63wQfBfFMKYRqY1gvJn0NwGrklRxaLsnclN88rwtDP9aagDQejfTrfdNYn9wbCW
         eieL/YUdpx1l/T/redcJbsl/eiOiH7QWwpWOfRXC3fEVxw0OO6zoAG2PMYeUm3CkuCQ/
         8YcokRkE/I5ExdycgEd2ecbltQJbCFA59PPJtEZYYVkiVQ2lZ4v2WHsgyfSIa1HCDbg9
         +Ij5GGDkitJA2uNYSlJDRrwTa6Fno53XzDlKPkDkXsGPWq4rpPaxWikCeIvMYA/UFW4W
         NrAn7JkkHtuO5RNiZxYhxQZapECDfXijXUpqQNKq/8IYHuSLpkpA8lIZhxQSVjf2YABb
         5etg==
X-Gm-Message-State: ACgBeo1wI+HuX6rCJEuOX13UNnUW9O9TpiV3wZrRVwdQ8skPAQlGKFc+
        zwfya2hc3stJJwEGKrHwWBU=
X-Google-Smtp-Source: AA6agR6CK0dgn5za4iuMx9d4MJbeHQVRAXvhXKiNgEkVTDnP6vLuBWeZyp5E5Yy9G+xFzfRgjsI6dQ==
X-Received: by 2002:a05:6870:6019:b0:10c:a59f:e1ca with SMTP id t25-20020a056870601900b0010ca59fe1camr3706655oaa.200.1659724592516;
        Fri, 05 Aug 2022 11:36:32 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:bd0a:ecc8:60c4:4ecc? (2603-8081-140c-1a00-bd0a-ecc8-60c4-4ecc.res6.spectrum.com. [2603:8081:140c:1a00:bd0a:ecc8:60c4:4ecc])
        by smtp.gmail.com with ESMTPSA id n5-20020a056870240500b0010dc461410bsm838261oap.38.2022.08.05.11.36.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 11:36:32 -0700 (PDT)
Message-ID: <168fd702-36af-a40c-dcb7-144d2fdfdcfe@gmail.com>
Date:   Fri, 5 Aug 2022 13:36:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 1/2] RDMA/rxe: Set pd early in mr alloc routines
Content-Language: en-US
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, lizhijian@fujitsu.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
References: <20220805183153.32007-1-rpearsonhpe@gmail.com>
 <20220805183153.32007-2-rpearsonhpe@gmail.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20220805183153.32007-2-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/5/22 13:31, Bob Pearson wrote:
> Move setting of pd in mr objects ahead of any possible errors
> so that it will always be set in rxe_mr_complete() to avoid
> seg faults when rxe_put(mr_pd(mr)) is called.
> 
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>

Ignore I missed the for-next
