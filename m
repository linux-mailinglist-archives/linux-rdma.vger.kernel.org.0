Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B88A4708B98
	for <lists+linux-rdma@lfdr.de>; Fri, 19 May 2023 00:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbjERWaV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 May 2023 18:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjERWaV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 18 May 2023 18:30:21 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF23DE50;
        Thu, 18 May 2023 15:30:19 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6ab2d14e999so1843977a34.0;
        Thu, 18 May 2023 15:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684449019; x=1687041019;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1kMliYPxreaa++8XO+JGm6LZMSC93a7bBDrfnonNsgU=;
        b=ZxHHpL0otY84IKO004l+/VrEt7m0Ty1U7+/7WzwvU6ChOsyVjqwUPx8w0B7wfSF4QG
         m5UBhtxi1ZaS9vHiSoGn4ZEg9Tb70EpcQxiXKRHPsoadR4y5wiDTqAt/mZOYCtYSG49X
         7UvcOGjhDNI+v0xf6Ll/S4z6pMMm8qz/ywMEqMit+CzfnVYwGc8LkeU/p7KXH8vAto1v
         1K6/foLQKsmfZOZXv2afh5SXGfR/GCANBvESsn2Efgea0ne24GcsbmTtVhcoqPfboWUg
         X5kvFsVMBuhsQbNMK6TAMRbd5e/A7OQultvSEcEKt/lqSIfUxUeZ93w+b4VoVtNgbePK
         K56g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684449019; x=1687041019;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1kMliYPxreaa++8XO+JGm6LZMSC93a7bBDrfnonNsgU=;
        b=MjnpJRVK5hgN9wbHef0o4uYc2OA0ZarIsYvm8JNBs6IGy53yK6jeiLsfTsj1cVLV7t
         l7pnkpanhO7x9d9C92gBeUWlO3z6tDTXddvB7bXOAF6sVux0McN8lTds3+7GT1KNUDfg
         x8rVI2h8lJWo77uQnXRoW/2g3ue9LHcEnAZmzs7A8pXtQSKWxldgpf/4SNSp5k9pWVNf
         CkmIqIR22bQlhz2S2i7Dx0vUsqj8YeTkJ0Me7wc46siv3UUKX3c5YKaP7Swfpx7sZuJG
         Ues58cL0GN8WALak4VrGuWVu4dl+r7wKkJwkUOF0tvSrhCtL1aE9SxaPtpPIqzvZd0cw
         X8KA==
X-Gm-Message-State: AC+VfDy7mszb/pJDuMYvpCWoE6aCYIQ8vRXHdiVm9UWhcsc1pyCSsbOU
        PYFvXR9Nwubo7wprifz4sQAE62dDkxpcmw==
X-Google-Smtp-Source: ACHHUZ7qYLxQYnhhfBAAQfOQonSFts6RMSpmaoMep3u6pt4hILOZRLbx0f8a4rVwyGa2LRhGpago4Q==
X-Received: by 2002:a05:6830:1413:b0:6ab:840:c498 with SMTP id v19-20020a056830141300b006ab0840c498mr21192otp.33.1684449019213;
        Thu, 18 May 2023 15:30:19 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:1b3d:4b6b:e581:f922? (2603-8081-140c-1a00-1b3d-4b6b-e581-f922.res6.spectrum.com. [2603:8081:140c:1a00:1b3d:4b6b:e581:f922])
        by smtp.gmail.com with ESMTPSA id g15-20020a9d6a0f000000b006ab1dd9eedesm1127723otn.49.2023.05.18.15.30.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 May 2023 15:30:18 -0700 (PDT)
Message-ID: <2d4f6023-0897-2414-45c0-e16b119dd9fb@gmail.com>
Date:   Thu, 18 May 2023 17:30:17 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH for-next v5 3/7] RDMA/rxe: Move resp_states definition to
 rxe_verbs.h
Content-Language: en-US
To:     Daisuke Matsuda <matsuda-daisuke@fujitsu.com>,
        linux-rdma@vger.kernel.org, leonro@nvidia.com, jgg@nvidia.com,
        zyjzyj2000@gmail.com
Cc:     linux-kernel@vger.kernel.org, yangx.jy@fujitsu.com,
        lizhijian@fujitsu.com, y-goto@fujitsu.com
References: <cover.1684397037.git.matsuda-daisuke@fujitsu.com>
 <a30a265438358d15068b6434795e00293a63fed5.1684397037.git.matsuda-daisuke@fujitsu.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <a30a265438358d15068b6434795e00293a63fed5.1684397037.git.matsuda-daisuke@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UPPERCASE_50_75 autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/18/23 03:21, Daisuke Matsuda wrote:
> To use the resp_states values in rxe_loc.h, it is necessary to move the
> definition to rxe_verbs.h, where other internal states of this driver are
> defined.
> 
> Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
> ---
>  drivers/infiniband/sw/rxe/rxe.h       | 37 ---------------------------
>  drivers/infiniband/sw/rxe/rxe_verbs.h | 37 +++++++++++++++++++++++++++
>  2 files changed, 37 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe.h b/drivers/infiniband/sw/rxe/rxe.h
> index d33dd6cf83d3..9b4d044a1264 100644
> --- a/drivers/infiniband/sw/rxe/rxe.h
> +++ b/drivers/infiniband/sw/rxe/rxe.h
> @@ -100,43 +100,6 @@
>  #define rxe_info_mw(mw, fmt, ...) ibdev_info_ratelimited((mw)->ibmw.device, \
>  		"mw#%d %s:  " fmt, (mw)->elem.index, __func__, ##__VA_ARGS__)
>  
> -/* responder states */
> -enum resp_states {
> -	RESPST_NONE,
> -	RESPST_GET_REQ,
> -	RESPST_CHK_PSN,
> -	RESPST_CHK_OP_SEQ,
> -	RESPST_CHK_OP_VALID,
> -	RESPST_CHK_RESOURCE,
> -	RESPST_CHK_LENGTH,
> -	RESPST_CHK_RKEY,
> -	RESPST_EXECUTE,
> -	RESPST_READ_REPLY,
> -	RESPST_ATOMIC_REPLY,
> -	RESPST_ATOMIC_WRITE_REPLY,
> -	RESPST_PROCESS_FLUSH,
> -	RESPST_COMPLETE,
> -	RESPST_ACKNOWLEDGE,
> -	RESPST_CLEANUP,
> -	RESPST_DUPLICATE_REQUEST,
> -	RESPST_ERR_MALFORMED_WQE,
> -	RESPST_ERR_UNSUPPORTED_OPCODE,
> -	RESPST_ERR_MISALIGNED_ATOMIC,
> -	RESPST_ERR_PSN_OUT_OF_SEQ,
> -	RESPST_ERR_MISSING_OPCODE_FIRST,
> -	RESPST_ERR_MISSING_OPCODE_LAST_C,
> -	RESPST_ERR_MISSING_OPCODE_LAST_D1E,
> -	RESPST_ERR_TOO_MANY_RDMA_ATM_REQ,
> -	RESPST_ERR_RNR,
> -	RESPST_ERR_RKEY_VIOLATION,
> -	RESPST_ERR_INVALIDATE_RKEY,
> -	RESPST_ERR_LENGTH,
> -	RESPST_ERR_CQ_OVERFLOW,
> -	RESPST_ERROR,
> -	RESPST_DONE,
> -	RESPST_EXIT,
> -};
> -
>  void rxe_set_mtu(struct rxe_dev *rxe, unsigned int dev_mtu);
>  
>  int rxe_add(struct rxe_dev *rxe, unsigned int mtu, const char *ibdev_name);
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
> index 26a20f088692..b6fbd9b3d086 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
> @@ -127,6 +127,43 @@ struct rxe_comp_info {
>  	struct rxe_task		task;
>  };
>  
> +/* responder states */
> +enum resp_states {
> +	RESPST_NONE,
> +	RESPST_GET_REQ,
> +	RESPST_CHK_PSN,
> +	RESPST_CHK_OP_SEQ,
> +	RESPST_CHK_OP_VALID,
> +	RESPST_CHK_RESOURCE,
> +	RESPST_CHK_LENGTH,
> +	RESPST_CHK_RKEY,
> +	RESPST_EXECUTE,
> +	RESPST_READ_REPLY,
> +	RESPST_ATOMIC_REPLY,
> +	RESPST_ATOMIC_WRITE_REPLY,
> +	RESPST_PROCESS_FLUSH,
> +	RESPST_COMPLETE,
> +	RESPST_ACKNOWLEDGE,
> +	RESPST_CLEANUP,
> +	RESPST_DUPLICATE_REQUEST,
> +	RESPST_ERR_MALFORMED_WQE,
> +	RESPST_ERR_UNSUPPORTED_OPCODE,
> +	RESPST_ERR_MISALIGNED_ATOMIC,
> +	RESPST_ERR_PSN_OUT_OF_SEQ,
> +	RESPST_ERR_MISSING_OPCODE_FIRST,
> +	RESPST_ERR_MISSING_OPCODE_LAST_C,
> +	RESPST_ERR_MISSING_OPCODE_LAST_D1E,
> +	RESPST_ERR_TOO_MANY_RDMA_ATM_REQ,
> +	RESPST_ERR_RNR,
> +	RESPST_ERR_RKEY_VIOLATION,
> +	RESPST_ERR_INVALIDATE_RKEY,
> +	RESPST_ERR_LENGTH,
> +	RESPST_ERR_CQ_OVERFLOW,
> +	RESPST_ERROR,
> +	RESPST_DONE,
> +	RESPST_EXIT,
> +};
> +
>  enum rdatm_res_state {
>  	rdatm_res_state_next,
>  	rdatm_res_state_new,

Looks OK.

Reviewed-by: Bob Pearson <rpearsonhpe@gmail.com>

